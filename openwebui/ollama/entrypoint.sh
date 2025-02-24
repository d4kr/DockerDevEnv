#!/bin/bash

# Funzione per gestire i segnali di arresto
handle_shutdown() {
    echo "Received shutdown signal, stopping Ollama..."
    kill -SIGTERM "$ollama_pid"
    wait "$ollama_pid"
    echo "Ollama stopped."
}

# Attende che Ollama sia pronto
wait_for_ollama() {
    echo "Waiting for Ollama to start..."
    until curl -s http://localhost:11434/api/tags > /dev/null; do
        sleep 1
    done
    echo "Ollama is ready!"
}

# Legge la variabile di ambiente OLLAMA_MODEL
if [ -z "$OLLAMA_MODEL" ]; then
    echo "Error: OLLAMA_MODEL environment variable is not set."
    exit 1
fi

# Avvia Ollama in background
ollama serve &
ollama_pid=$!

# Registra la funzione di gestione dei segnali
trap handle_shutdown SIGTERM SIGINT

# Attendi che Ollama sia pronto
wait_for_ollama

# Scarica il modello specificato
echo "Downloading model: $OLLAMA_MODEL"
ollama pull "$OLLAMA_MODEL"

# Verifica se il download è riuscito
if [ $? -ne 0 ]; then
    echo "Error: Failed to download model '$OLLAMA_MODEL'. Exiting..."
    exit 1
fi

# Verifica che il modello sia disponibile
echo "Checking if model is available..."
if ! ollama list | grep -q "$OLLAMA_MODEL"; then
    echo "Error: Model '$OLLAMA_MODEL' is not available after download. Exiting..."
    exit 1
fi

echo "Model '$OLLAMA_MODEL' is ready!"

# Attendi finché il processo Ollama è in esecuzione
wait $ollama_pid