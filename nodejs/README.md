# tokenmix-tg-bot

[![npm version](https://img.shields.io/npm/v/tokenmix-tg-bot.svg)](https://www.npmjs.com/package/tokenmix-tg-bot)
[![Node.js](https://img.shields.io/node/v/tokenmix-tg-bot.svg)](https://nodejs.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by TokenMix](https://img.shields.io/badge/Powered%20by-TokenMix.ai-blue)](https://tokenmix.ai)

> **Your own AI chatbot on Telegram. One file, one command, 155+ models.**

Streaming responses + vision support. Powered by [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ other LLMs.

## Install

```bash
npm install -g tokenmix-tg-bot
```

Or run directly with npx:

```bash
npx tokenmix-tg-bot
```

## Setup

Create a `.env` file in your working directory:

```
BOT_TOKEN=your_telegram_bot_token
API_KEY=your_tokenmix_api_key
BASE_URL=https://api.tokenmix.ai/v1
DEFAULT_MODEL=gpt-4o-mini
```

You need:

- **Telegram bot token** — message [@BotFather](https://t.me/BotFather), type `/newbot`.
- **LLM API key** — get one free at [TokenMix.ai](https://tokenmix.ai) ($1 free credit, 155+ models).

## Run

```bash
tokenmix-tg-bot
```

## Features

- 🌊 Streaming responses (smooth incremental output)
- 🖼️ Vision support — send a photo with optional caption
- 🔀 Switch models on the fly: `/model gpt-5`, `/model claude-3.5-sonnet`
- 🔄 Reset conversation: `/reset`
- 🪶 Tiny — single file, three deps

## Models

Any model on TokenMix works out of the box: GPT-5, GPT-4o, Claude 3.5 Sonnet, Gemini 2.0, DeepSeek-V3, Llama 3.3, Qwen 2.5, and 150+ more.

Browse the full list at [tokenmix.ai](https://tokenmix.ai).

## License

MIT © TokenMix
