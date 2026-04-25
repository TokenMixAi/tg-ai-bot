# tokenmix-cli

[![crates.io](https://img.shields.io/crates/v/tokenmix-cli.svg)](https://crates.io/crates/tokenmix-cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by TokenMix](https://img.shields.io/badge/Powered%20by-TokenMix.ai-blue)](https://tokenmix.ai)

> Command-line interface for [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.

## Install

    cargo install tokenmix-cli

## Quick Start

Set your API key (get one free at [tokenmix.ai](https://tokenmix.ai)):

    export TOKENMIX_API_KEY=tm-your_key_here

Send a chat message:

    tokenmix chat "Explain Rust ownership in 2 sentences"

List available models:

    tokenmix models

Use a specific model:

    tokenmix --model claude-opus-4-5 chat "Hello"
    tokenmix --model gpt-5 chat "Hello"
    tokenmix --model deepseek-v3 chat "Hello"

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `TOKENMIX_API_KEY` | required | API key from [tokenmix.ai](https://tokenmix.ai) |
| `TOKENMIX_BASE_URL` | `https://api.tokenmix.ai/v1` | API endpoint |
| `TOKENMIX_MODEL` | `gpt-4o-mini` | Default model |

Or pass via flags: `--api-key`, `--base-url`, `--model`.

## Why TokenMix?

If you build with multiple LLM providers, [TokenMix](https://tokenmix.ai) gives you:

- One API key for OpenAI, Anthropic, Google, DeepSeek, Mistral, Qwen and more
- Unified billing — pay-as-you-go from $0.10/M tokens
- $1 free credit on signup
- OpenAI-compatible — drop-in replacement

[Get a free API key →](https://tokenmix.ai)

## Other Languages

- **Python** (PyPI): `pip install tokenmix-tg-bot` — Telegram bot
- **Node.js** (npm): `npm install -g tokenmix-tg-bot` — Telegram bot
- **Docker**: `docker pull tokenmixai/tg-ai-bot` — pre-built image

## Links

- Get API key: [tokenmix.ai](https://tokenmix.ai)
- Docs: [tokenmix.ai/docs](https://tokenmix.ai/docs)
- GitHub: [TokenMixAi/tg-ai-bot](https://github.com/TokenMixAi/tg-ai-bot)
- Issues: [Report a bug](https://github.com/TokenMixAi/tg-ai-bot/issues)

## License

MIT
