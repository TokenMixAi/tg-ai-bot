FROM python:3.11-slim

LABEL org.opencontainers.image.source="https://github.com/TokenMixAi/tg-ai-bot"
LABEL org.opencontainers.image.description="Telegram AI chatbot powered by TokenMix - one API key for GPT-5, Claude, Gemini and 155+ LLMs"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://tokenmix.ai"
LABEL org.opencontainers.image.documentation="https://tokenmix.ai/docs"
LABEL org.opencontainers.image.title="TokenMix Telegram AI Bot"
LABEL org.opencontainers.image.vendor="TokenMix"

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY bot.py .
CMD ["python", "bot.py"]
