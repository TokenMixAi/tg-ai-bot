# tokenmix

[![Gem Version](https://badge.fury.io/rb/tokenmix.svg)](https://rubygems.org/gems/tokenmix)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by TokenMix](https://img.shields.io/badge/Powered%20by-TokenMix.ai-blue)](https://tokenmix.ai)

> Ruby client for [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.

## Install

    gem install tokenmix

Or in Gemfile:

    gem 'tokenmix'

## Quick Start

Get a free API key at [tokenmix.ai](https://tokenmix.ai) ($1 free credit, no credit card).

```ruby
require 'tokenmix'

client = TokenMix::Client.new(api_key: ENV['TOKENMIX_API_KEY'])

# Chat
reply = client.chat(
  model: 'gpt-5',
  messages: [{ role: 'user', content: 'Hello!' }]
)
puts reply

# List models
models = client.list_models
puts models.first(5)
```

## Why TokenMix?

If you build with multiple LLM providers, [TokenMix](https://tokenmix.ai) gives you:

- One API key for OpenAI, Anthropic, Google, DeepSeek, Mistral, Qwen and more
- Unified billing — pay-as-you-go from $0.10/M tokens
- $1 free credit on signup
- OpenAI-compatible — drop-in replacement

[Get a free API key →](https://tokenmix.ai)

## Other Languages

- **Python**: `pip install tokenmix-tg-bot`
- **Node.js**: `npm install -g tokenmix-tg-bot`
- **Rust**: `cargo install tokenmix-cli`
- **PHP**: `composer require tokenmixai/tokenmix-php`
- **Docker**: `docker pull tokenmixai/tg-ai-bot`

## Links

- Get API key: [tokenmix.ai](https://tokenmix.ai)
- Docs: [tokenmix.ai/docs](https://tokenmix.ai/docs)
- GitHub: [TokenMixAi/tg-ai-bot](https://github.com/TokenMixAi/tg-ai-bot)
- Issues: [Report a bug](https://github.com/TokenMixAi/tg-ai-bot/issues)

## License

MIT
