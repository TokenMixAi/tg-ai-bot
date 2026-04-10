# tg-ai-bot

Your own AI chatbot on Telegram. One file, one command, 155+ models.

Supports any OpenAI-compatible API. Streams responses in real time.
Send photos and the bot can see them (vision). Switch models mid-conversation.

## Setup

Two things you need:

1. **Telegram bot token** — message [@BotFather](https://t.me/BotFather), type `/newbot`, follow the steps
2. **LLM API key** — from [TokenMix.ai](https://tokenmix.ai) ($1 free credit, 155+ models) or any OpenAI-compatible provider

### Deploy with Docker (recommended)

```sh
git clone https://github.com/diaoyulao9657/tg-ai-bot
cd tg-ai-bot
cp .env.example .env
# edit .env — fill in BOT_TOKEN and API_KEY
docker compose up -d
```

Done. Open your bot on Telegram and say hi.

### Run without Docker

```sh
git clone https://github.com/diaoyulao9657/tg-ai-bot
cd tg-ai-bot
pip install -r requirements.txt
cp .env.example .env
# edit .env
python bot.py
```

## Features

- **Streaming** — responses appear word-by-word, not after a long wait
- **Vision** — send a photo with a question, the bot understands it
- **Voice messages** — send a voice note, it gets transcribed and answered
- **Markdown** — code blocks, bold, and other formatting render properly
- **Group chat** — in groups, responds only when @mentioned or replied to
- **Model switching** — `/model gpt-4o` to try a different model anytime
- **Conversation memory** — keeps context across messages (configurable depth)
- **Long replies** — responses over 4096 chars are split across multiple messages
- **Access control** — optionally restrict to specific Telegram user IDs

## Commands

```
/model <name>  — switch to a different model
/clear         — wipe conversation history
/help          — show commands
```

## Configuration

Everything is in `.env`:

| Variable | Required | Default | |
|----------|----------|---------|--|
| `BOT_TOKEN` | yes | — | From @BotFather |
| `API_KEY` | yes | — | LLM API key |
| `BASE_URL` | no | `https://api.tokenmix.ai/v1` | API endpoint |
| `MODEL` | no | `gpt-4o-mini` | Default model |
| `MAX_HISTORY` | no | `20` | Messages kept in context |
| `ALLOWED_USERS` | no | *(everyone)* | Comma-separated user IDs |
| `SYSTEM_PROMPT` | no | `You are a helpful assistant.` | System prompt |

Find your Telegram user ID by messaging [@userinfobot](https://t.me/userinfobot).

## How it works

It's one Python file. The bot receives messages via Telegram's API,
forwards them to an LLM through the OpenAI-compatible chat completions
endpoint, and streams the response back by editing the message as tokens
arrive. Photos are base64-encoded and sent as vision inputs.

Conversation history is stored in memory (resets when the bot restarts).
For most use cases this is fine — if you need persistence, a database
would be straightforward to add.

## License

MIT
