FROM linuxserver/code-server:latest

# Passa all'utente root per installare le estensioni
USER root

# Copia lo script di entrypoint personalizzato
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Imposta il nuovo entrypoint
ENTRYPOINT ["/entrypoint.sh"]
