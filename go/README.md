# tokenmix-go

[![Go Reference](https://pkg.go.dev/badge/github.com/TokenMixAi/tg-ai-bot/go.svg)](https://pkg.go.dev/github.com/TokenMixAi/tg-ai-bot/go)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by TokenMix](https://img.shields.io/badge/Powered%20by-TokenMix.ai-blue)](https://tokenmix.ai)

> Go client for [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.

## Install

    go get github.com/TokenMixAi/tg-ai-bot/go

## Quick Start

Get a free API key at [tokenmix.ai](https://tokenmix.ai) ($1 free credit).

```go
package main

import (
    "fmt"
    "os"

    tokenmix "github.com/TokenMixAi/tg-ai-bot/go"
)

func main() {
    client := tokenmix.NewClient(os.Getenv("TOKENMIX_API_KEY"))

    reply, err := client.Chat("gpt-5", []tokenmix.Message{
        {Role: "user", Content: "Hello!"},
    })
    if err != nil {
        panic(err)
    }
    fmt.Println(reply)

    models, _ := client.ListModels()
    fmt.Println("Available models:", len(models))
}
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
- **Ruby**: `gem install tokenmix`
- **PHP**: `composer require tokenmixai/tokenmix-php`
- **Docker**: `docker pull tokenmixai/tg-ai-bot`

## Links

- Get API key: [tokenmix.ai](https://tokenmix.ai)
- Docs: [tokenmix.ai/docs](https://tokenmix.ai/docs)
- GitHub: [TokenMixAi/tg-ai-bot](https://github.com/TokenMixAi/tg-ai-bot)
- Issues: [Report a bug](https://github.com/TokenMixAi/tg-ai-bot/issues)

## License

MIT
