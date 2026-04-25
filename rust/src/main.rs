use clap::{Parser, Subcommand};
use serde_json::{json, Value};
use std::process;

/// CLI for TokenMix — one API key for 155+ LLMs.
/// Get a free key at https://tokenmix.ai
#[derive(Parser)]
#[command(name = "tokenmix", version, about, long_about = None)]
struct Cli {
    /// Your TokenMix API key (or set TOKENMIX_API_KEY env var)
    #[arg(long, env = "TOKENMIX_API_KEY", hide_env_values = true)]
    api_key: Option<String>,

    /// API base URL
    #[arg(long, default_value = "https://api.tokenmix.ai/v1", env = "TOKENMIX_BASE_URL")]
    base_url: String,

    /// Model to use
    #[arg(short, long, default_value = "gpt-4o-mini", env = "TOKENMIX_MODEL")]
    model: String,

    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Send a single chat message
    Chat {
        /// The message to send
        prompt: String,
    },
    /// List available models
    Models,
}

#[tokio::main]
async fn main() {
    let cli = Cli::parse();

    let api_key = match cli.api_key {
        Some(k) => k,
        None => {
            eprintln!("Error: API key required");
            eprintln!("Set TOKENMIX_API_KEY env var or use --api-key");
            eprintln!("Get a free API key at https://tokenmix.ai");
            process::exit(1);
        }
    };

    let client = reqwest::Client::new();

    match cli.command {
        Commands::Chat { prompt } => {
            let url = format!("{}/chat/completions", cli.base_url);
            let resp = client
                .post(&url)
                .bearer_auth(&api_key)
                .json(&json!({
                    "model": cli.model,
                    "messages": [{"role": "user", "content": prompt}]
                }))
                .send()
                .await;

            match resp {
                Ok(r) => {
                    let body: Value = match r.json().await {
                        Ok(v) => v,
                        Err(e) => {
                            eprintln!("Error parsing response: {}", e);
                            process::exit(1);
                        }
                    };
                    if let Some(content) = body["choices"][0]["message"]["content"].as_str() {
                        println!("{}", content);
                    } else {
                        eprintln!("Unexpected response: {}", body);
                        process::exit(1);
                    }
                }
                Err(e) => {
                    eprintln!("Request failed: {}", e);
                    eprintln!("See https://tokenmix.ai/docs for help");
                    process::exit(1);
                }
            }
        }
        Commands::Models => {
            let url = format!("{}/models", cli.base_url);
            let resp = client.get(&url).bearer_auth(&api_key).send().await;

            match resp {
                Ok(r) => {
                    let body: Value = match r.json().await {
                        Ok(v) => v,
                        Err(e) => {
                            eprintln!("Error parsing response: {}", e);
                            process::exit(1);
                        }
                    };
                    if let Some(arr) = body["data"].as_array() {
                        for m in arr {
                            if let Some(id) = m["id"].as_str() {
                                println!("{}", id);
                            }
                        }
                    } else {
                        eprintln!("Unexpected response: {}", body);
                        process::exit(1);
                    }
                }
                Err(e) => {
                    eprintln!("Request failed: {}", e);
                    process::exit(1);
                }
            }
        }
    }
}
