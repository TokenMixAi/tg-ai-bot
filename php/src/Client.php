<?php
declare(strict_types=1);

namespace TokenMix;

/**
 * TokenMix PHP Client.
 *
 * One API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.
 * Get a free API key at https://tokenmix.ai
 */
class Client
{
    public function __construct(
        private string $apiKey,
        private string $baseUrl = 'https://api.tokenmix.ai/v1'
    ) {}

    /**
     * Send a chat completion request.
     *
     * @param string $model    Model name (e.g. "gpt-5", "claude-opus-4-5")
     * @param array  $messages Array of {"role": "user|assistant|system", "content": "..."}
     *
     * @return string The assistant's reply content
     * @throws \RuntimeException on API errors
     */
    public function chat(string $model, array $messages): string
    {
        $body = json_encode([
            'model' => $model,
            'messages' => $messages,
        ], JSON_UNESCAPED_UNICODE);

        $ch = curl_init($this->baseUrl . '/chat/completions');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_HTTPHEADER => [
                'Authorization: Bearer ' . $this->apiKey,
                'Content-Type: application/json',
            ],
            CURLOPT_POSTFIELDS => $body,
            CURLOPT_TIMEOUT => 60,
        ]);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $err = curl_error($ch);
        curl_close($ch);

        if ($response === false) {
            throw new \RuntimeException("Request failed: $err");
        }

        $data = json_decode($response, true);

        if ($httpCode !== 200) {
            $msg = $data['error']['message'] ?? "HTTP $httpCode";
            throw new \RuntimeException("TokenMix API error: $msg");
        }

        return $data['choices'][0]['message']['content'] ?? '';
    }

    /**
     * List available models.
     *
     * @return array of model IDs
     */
    public function listModels(): array
    {
        $ch = curl_init($this->baseUrl . '/models');
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER => ['Authorization: Bearer ' . $this->apiKey],
            CURLOPT_TIMEOUT => 30,
        ]);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode !== 200) {
            throw new \RuntimeException("Failed to list models (HTTP $httpCode)");
        }

        $data = json_decode($response, true);
        return array_column($data['data'] ?? [], 'id');
    }
}
