# Usa un'immagine di base ARM64 per Apple Silicon
FROM debian:latest

# Evita prompt interattivi durante l'installazione
ENV DEBIAN_FRONTEND=noninteractive

# Installa dipendenze necessarie
RUN apt-get update && apt-get install -y \
    curl \
    git \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Scarica e installa Ollama per ARM64
RUN curl -fsSL https://ollama.com/install.sh | sh

# Espone la porta usata da Ollama
EXPOSE 11434

# Avvia Ollama
CMD ["ollama", "serve"]