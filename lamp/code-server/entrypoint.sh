#!/bin/bash
# Forza la proprietà e i permessi sull'intera directory /config
chown -R abc:abc /config
chmod -R 777 /config

# Elimina e ricrea la directory delle estensioni
rm -rf /config/extensions
mkdir -p /config/extensions
chown abc:abc /config/extensions
chmod 777 /config/extensions

# Rimuovi (se esiste) il file extensions.json e ricrealo con contenuto valido
rm -f /config/extensions/extensions.json
echo "[]" > /config/extensions/extensions.json
chmod 666 /config/extensions/extensions.json

# Imposta (o aggiorna) il workspace come link simbolico a /var/www/html
rm -rf /config/workspace
ln -s /var/www/html /config/workspace

# Configura code-server per usare il percorso custom delle estensioni
CONFIG_DIR="/config/.config/code-server"
mkdir -p "$CONFIG_DIR"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
if [ -f "$CONFIG_FILE" ]; then
  if ! grep -q '^extensions-dir:' "$CONFIG_FILE"; then
    echo "extensions-dir: /config/extensions" >> "$CONFIG_FILE"
  else
    sed -i 's|^extensions-dir:.*|extensions-dir: /config/extensions|' "$CONFIG_FILE"
  fi
else
  echo "extensions-dir: /config/extensions" > "$CONFIG_FILE"
fi

# (Opzionale) Mostra i permessi per debug
echo "Contenuto di /config/extensions:"
ls -la /config/extensions

# Installa le estensioni come utente "abc"
su -s /bin/sh abc -c '/app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension felixfbecker.php-debug'
su -s /bin/sh abc -c '/app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension bmewburn.vscode-intelephense-client'
su -s /bin/sh abc -c '/app/code-server/bin/code-server --extensions-dir /config/extensions --install-extension mehedidracula.php-namespace-resolver'

# Avvia l'entrypoint originale dell'immagine
exec /init "$@"
