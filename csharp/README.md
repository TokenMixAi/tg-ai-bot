# TokenMix.AI — .NET Client

[![NuGet](https://img.shields.io/nuget/v/TokenMix.AI.svg)](https://www.nuget.org/packages/TokenMix.AI)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by TokenMix](https://img.shields.io/badge/Powered%20by-TokenMix.ai-blue)](https://tokenmix.ai)

> .NET client for [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.

## Install

```bash
dotnet add package TokenMix.AI
```

## Usage

```csharp
using TokenMix;

using var client = new Client(Environment.GetEnvironmentVariable("TOKENMIX_API_KEY")!);

var reply = await client.ChatAsync("gpt-5", new[] {
    new Message { Role = "user", Content = "Hello!" }
});
Console.WriteLine(reply);

var models = await client.ListModelsAsync();
Console.WriteLine($"{models.Count} models available");
```

## Get an API key

Free $1 credit at [tokenmix.ai](https://tokenmix.ai), no credit card required.

## Features

- OpenAI-compatible Bearer auth
- Async/await with `CancellationToken` support
- Inject your own `HttpClient` (for retries, mocking, shared lifetime)
- Modern .NET 8, nullable reference types
- Tiny — single file, zero extra dependencies

## Other Languages

- **Python**: `pip install tokenmix-tg-bot`
- **Node.js**: `npm install -g tokenmix-tg-bot`
- **Rust**: `cargo install tokenmix-cli`
- **Ruby**: `gem install tokenmix`
- **PHP**: `composer require tokenmixai/tokenmix-php`
- **Go**: `go get github.com/TokenMixAi/tg-ai-bot/go`
- **Docker**: `docker pull tokenmixai/tg-ai-bot`

## Links

- Get API key: [tokenmix.ai](https://tokenmix.ai)
- Docs: [tokenmix.ai/docs](https://tokenmix.ai/docs)
- GitHub: [TokenMixAi/tg-ai-bot](https://github.com/TokenMixAi/tg-ai-bot)
- Issues: [Report a bug](https://github.com/TokenMixAi/tg-ai-bot/issues)

## License

MIT
