using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json.Serialization;

namespace TokenMix;

/// <summary>
/// Client for TokenMix — one API key for GPT-5, Claude, Gemini, DeepSeek and 155+ LLMs.
/// Get a free API key at https://tokenmix.ai
/// </summary>
public sealed class Client : IDisposable
{
    public const string DefaultBaseUrl = "https://api.tokenmix.ai/v1";

    private readonly HttpClient _http;
    private readonly bool _ownsHttp;
    private readonly string _baseUrl;

    public Client(string apiKey, string? baseUrl = null, HttpClient? http = null)
    {
        if (string.IsNullOrWhiteSpace(apiKey))
            throw new ArgumentException("apiKey is required", nameof(apiKey));

        _baseUrl = baseUrl ?? DefaultBaseUrl;
        _http = http ?? new HttpClient();
        _ownsHttp = http is null;
        _http.DefaultRequestHeaders.Authorization =
            new AuthenticationHeaderValue("Bearer", apiKey);
    }

    /// <summary>Send a chat completion request and return the assistant reply.</summary>
    public async Task<string> ChatAsync(
        string model,
        IEnumerable<Message> messages,
        CancellationToken ct = default)
    {
        var resp = await _http.PostAsJsonAsync(
            $"{_baseUrl}/chat/completions",
            new ChatRequest { Model = model, Messages = messages },
            ct).ConfigureAwait(false);
        resp.EnsureSuccessStatusCode();
        var data = await resp.Content
            .ReadFromJsonAsync<ChatResponse>(cancellationToken: ct)
            .ConfigureAwait(false);
        return data?.Choices?.FirstOrDefault()?.Message?.Content ?? string.Empty;
    }

    /// <summary>List available model IDs.</summary>
    public async Task<IReadOnlyList<string>> ListModelsAsync(CancellationToken ct = default)
    {
        var resp = await _http.GetAsync($"{_baseUrl}/models", ct).ConfigureAwait(false);
        resp.EnsureSuccessStatusCode();
        var data = await resp.Content
            .ReadFromJsonAsync<ModelsResponse>(cancellationToken: ct)
            .ConfigureAwait(false);
        var ids = new List<string>();
        if (data?.Data is not null)
            foreach (var m in data.Data)
                if (!string.IsNullOrEmpty(m.Id)) ids.Add(m.Id);
        return ids;
    }

    public void Dispose()
    {
        if (_ownsHttp) _http.Dispose();
    }
}

/// <summary>A chat message (role: "user" / "assistant" / "system").</summary>
public sealed class Message
{
    [JsonPropertyName("role")]
    public string Role { get; init; } = "user";

    [JsonPropertyName("content")]
    public string Content { get; init; } = string.Empty;
}

internal sealed class ChatRequest
{
    [JsonPropertyName("model")]
    public required string Model { get; init; }

    [JsonPropertyName("messages")]
    public required IEnumerable<Message> Messages { get; init; }
}

internal sealed class ChatResponse
{
    [JsonPropertyName("choices")]
    public List<Choice>? Choices { get; init; }
}

internal sealed class Choice
{
    [JsonPropertyName("message")]
    public Message? Message { get; init; }
}

internal sealed class ModelsResponse
{
    [JsonPropertyName("data")]
    public List<Model>? Data { get; init; }
}

internal sealed class Model
{
    [JsonPropertyName("id")]
    public string? Id { get; init; }
}
