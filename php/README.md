# tokenmix-php

PHP client for [TokenMix](https://tokenmix.ai) — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.

## Install

```bash
composer require tokenmixai/tokenmix-php
```

## Usage

```php
<?php
require 'vendor/autoload.php';

use TokenMix\Client;

$client = new Client(getenv('TOKENMIX_API_KEY'));

// Chat
$reply = $client->chat('gpt-5', [
    ['role' => 'user', 'content' => 'Hello!']
]);
echo $reply;

// List models
$models = $client->listModels();
print_r($models);
```

## Get an API key

Free $1 credit at [tokenmix.ai](https://tokenmix.ai), no credit card required.

## Other Languages

- **Python**: `pip install tokenmix-tg-bot`
- **Node.js**: `npm install -g tokenmix-tg-bot`
- **Rust**: `cargo install tokenmix-cli`
- **Docker**: `docker pull tokenmixai/tg-ai-bot`

## Links

- Get API key: [tokenmix.ai](https://tokenmix.ai)
- Docs: [tokenmix.ai/docs](https://tokenmix.ai/docs)
- GitHub: [TokenMixAi/tg-ai-bot](https://github.com/TokenMixAi/tg-ai-bot)

## License

MIT
