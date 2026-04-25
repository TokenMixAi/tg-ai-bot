Gem::Specification.new do |spec|
  spec.name          = 'tokenmix'
  spec.version       = '0.1.0'
  spec.authors       = ['TokenMix']
  spec.email         = ['hello@tokenmix.ai']

  spec.summary       = 'Ruby client for TokenMix — one API key for 155+ LLMs'
  spec.description   = 'Ruby client for TokenMix — access GPT-5, Claude, Gemini, DeepSeek, Qwen, Mistral and 155+ other LLMs through a single OpenAI-compatible API key. Get a free key at https://tokenmix.ai'
  spec.homepage      = 'https://tokenmix.ai'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata = {
    'homepage_uri'      => 'https://tokenmix.ai',
    'source_code_uri'   => 'https://github.com/TokenMixAi/tg-ai-bot',
    'bug_tracker_uri'   => 'https://github.com/TokenMixAi/tg-ai-bot/issues',
    'documentation_uri' => 'https://tokenmix.ai/docs',
    'changelog_uri'     => 'https://github.com/TokenMixAi/tg-ai-bot/releases'
  }

  spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE']
  spec.require_paths = ['lib']
end
