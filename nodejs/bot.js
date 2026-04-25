#!/usr/bin/env node
import 'dotenv/config';
import { Telegraf } from 'telegraf';
import OpenAI from 'openai';

const {
  BOT_TOKEN,
  API_KEY,
  BASE_URL = 'https://api.tokenmix.ai/v1',
  DEFAULT_MODEL = 'gpt-4o-mini',
} = process.env;

if (!BOT_TOKEN || !API_KEY) {
  console.error('❌ Missing BOT_TOKEN or API_KEY in .env');
  console.error('   Get a free API key at https://tokenmix.ai');
  process.exit(1);
}

const bot = new Telegraf(BOT_TOKEN);
const openai = new OpenAI({ apiKey: API_KEY, baseURL: BASE_URL });

const sessions = new Map();
function getSession(chatId) {
  if (!sessions.has(chatId)) {
    sessions.set(chatId, { model: DEFAULT_MODEL, messages: [] });
  }
  return sessions.get(chatId);
}

bot.command('start', (ctx) => {
  const s = getSession(ctx.chat.id);
  ctx.reply(
    `👋 AI chatbot powered by TokenMix.\n\n` +
    `Current model: ${s.model}\n\n` +
    `Commands:\n` +
    `  /model <name> – switch model (e.g. /model gpt-5)\n` +
    `  /reset – clear conversation\n\n` +
    `Get an API key: https://tokenmix.ai`
  );
});

bot.command('model', (ctx) => {
  const arg = ctx.message.text.split(' ').slice(1).join(' ').trim();
  if (!arg) {
    ctx.reply(`Current: ${getSession(ctx.chat.id).model}\nUsage: /model gpt-5`);
    return;
  }
  const s = getSession(ctx.chat.id);
  s.model = arg;
  s.messages = [];
  ctx.reply(`✅ Switched to ${arg}`);
});

bot.command('reset', (ctx) => {
  getSession(ctx.chat.id).messages = [];
  ctx.reply('✅ Conversation cleared.');
});

async function handleMessage(ctx, content) {
  const session = getSession(ctx.chat.id);
  session.messages.push({ role: 'user', content });

  try {
    const stream = await openai.chat.completions.create({
      model: session.model,
      messages: session.messages,
      stream: true,
    });

    const placeholder = await ctx.reply('...');
    let buffer = '';
    let lastEdit = Date.now();

    for await (const chunk of stream) {
      const delta = chunk.choices[0]?.delta?.content || '';
      buffer += delta;
      if (Date.now() - lastEdit > 1500 && buffer.length > 0) {
        try {
          await ctx.telegram.editMessageText(
            ctx.chat.id, placeholder.message_id, undefined, buffer
          );
          lastEdit = Date.now();
        } catch {}
      }
    }
    if (buffer) {
      try {
        await ctx.telegram.editMessageText(
          ctx.chat.id, placeholder.message_id, undefined, buffer
        );
      } catch {}
    }
    session.messages.push({ role: 'assistant', content: buffer });
  } catch (err) {
    ctx.reply(`❌ ${err.message || 'Error'}`);
  }
}

bot.on('text', (ctx) => handleMessage(ctx, ctx.message.text));

bot.on('photo', async (ctx) => {
  const photo = ctx.message.photo.at(-1);
  const fileLink = await ctx.telegram.getFileLink(photo.file_id);
  const caption = ctx.message.caption || 'What do you see?';
  const content = [
    { type: 'text', text: caption },
    { type: 'image_url', image_url: { url: fileLink.href } },
  ];
  await handleMessage(ctx, content);
});

console.log(`🤖 Bot started (model: ${DEFAULT_MODEL})`);
console.log(`   Powered by TokenMix — https://tokenmix.ai`);
bot.launch();

process.once('SIGINT', () => bot.stop('SIGINT'));
process.once('SIGTERM', () => bot.stop('SIGTERM'));
