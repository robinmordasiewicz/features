#!/bin/bash -i

set -e

EXTENSIONS=${EXTENSIONS:-}

mkdir -p "/usr/local/share/ollama/"

cat <<EOF >/usr/local/share/ollama/oncreate.sh
#!/bin/env bash
set -e

MODELS="${MODELS}"
IFS=',' read -ra MODELS_ARRAY <<< "\$MODELS"
for ext in "\${MODELS_ARRAY[@]}"; do
  ollama pull "\${ext}"
done
exit 0
EOF

chmod 755 /usr/local/share/ollama/oncreate.sh
