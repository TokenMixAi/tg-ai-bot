// Package tokenmix is a Go client for TokenMix.
//
// One API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.
// Get a free API key at https://tokenmix.ai
package tokenmix

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
)

// DefaultBaseURL is the default TokenMix API endpoint.
const DefaultBaseURL = "https://api.tokenmix.ai/v1"

// Client is a TokenMix API client.
type Client struct {
	APIKey     string
	BaseURL    string
	HTTPClient *http.Client
}

// NewClient creates a new client with the given API key.
// Get a free API key at https://tokenmix.ai
func NewClient(apiKey string) *Client {
	return &Client{
		APIKey:     apiKey,
		BaseURL:    DefaultBaseURL,
		HTTPClient: http.DefaultClient,
	}
}

// Message is a chat message.
type Message struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// ChatRequest is a chat completion request body.
type ChatRequest struct {
	Model    string    `json:"model"`
	Messages []Message `json:"messages"`
}

// ChatResponse is a chat completion response.
type ChatResponse struct {
	Choices []struct {
		Message Message `json:"message"`
	} `json:"choices"`
}

// Chat sends a chat completion request and returns the assistant reply.
//
// Example models: "gpt-5", "claude-opus-4-5", "gemini-3-pro", "deepseek-v3".
func (c *Client) Chat(model string, messages []Message) (string, error) {
	reqBody := ChatRequest{Model: model, Messages: messages}
	var resp ChatResponse
	if err := c.post("/chat/completions", reqBody, &resp); err != nil {
		return "", err
	}
	if len(resp.Choices) == 0 {
		return "", fmt.Errorf("tokenmix: no choices in response")
	}
	return resp.Choices[0].Message.Content, nil
}

// ListModels returns the IDs of all available models.
func (c *Client) ListModels() ([]string, error) {
	var resp struct {
		Data []struct {
			ID string `json:"id"`
		} `json:"data"`
	}
	if err := c.get("/models", &resp); err != nil {
		return nil, err
	}
	ids := make([]string, len(resp.Data))
	for i, m := range resp.Data {
		ids[i] = m.ID
	}
	return ids, nil
}

func (c *Client) post(path string, body, out interface{}) error {
	payload, err := json.Marshal(body)
	if err != nil {
		return err
	}
	req, err := http.NewRequest("POST", c.BaseURL+path, bytes.NewReader(payload))
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bearer "+c.APIKey)
	req.Header.Set("Content-Type", "application/json")
	return c.do(req, out)
}

func (c *Client) get(path string, out interface{}) error {
	req, err := http.NewRequest("GET", c.BaseURL+path, nil)
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bearer "+c.APIKey)
	return c.do(req, out)
}

func (c *Client) do(req *http.Request, out interface{}) error {
	resp, err := c.HTTPClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	if resp.StatusCode >= 400 {
		body, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("tokenmix: HTTP %d: %s", resp.StatusCode, body)
	}
	return json.NewDecoder(resp.Body).Decode(out)
}
