require 'net/http'
require 'json'
require 'uri'

# Ruby client for TokenMix.
#
# One API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.
# Get a free API key at https://tokenmix.ai
module TokenMix
  VERSION = '0.1.0'.freeze

  class Error < StandardError; end

  class Client
    DEFAULT_BASE_URL = 'https://api.tokenmix.ai/v1'.freeze

    def initialize(api_key:, base_url: DEFAULT_BASE_URL)
      raise ArgumentError, 'api_key is required' if api_key.nil? || api_key.empty?
      @api_key = api_key
      @base_url = base_url
    end

    # Send a chat completion request.
    #
    # @param model [String] Model name (e.g. "gpt-5", "claude-opus-4-5")
    # @param messages [Array<Hash>] Array of {role:, content:}
    # @return [String] The assistant's reply
    def chat(model:, messages:)
      response = post('/chat/completions', model: model, messages: messages)
      response.dig('choices', 0, 'message', 'content')
    end

    # List available models.
    # @return [Array<String>] model IDs
    def list_models
      response = get('/models')
      (response['data'] || []).map { |m| m['id'] }
    end

    private

    def post(path, body)
      uri = URI("#{@base_url}#{path}")
      req = Net::HTTP::Post.new(uri)
      req['Authorization'] = "Bearer #{@api_key}"
      req['Content-Type'] = 'application/json'
      req.body = body.to_json
      send_request(uri, req)
    end

    def get(path)
      uri = URI("#{@base_url}#{path}")
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{@api_key}"
      send_request(uri, req)
    end

    def send_request(uri, req)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
      end
      unless response.is_a?(Net::HTTPSuccess)
        raise Error, "TokenMix API error: HTTP #{response.code}: #{response.body}"
      end
      JSON.parse(response.body)
    end
  end
end
