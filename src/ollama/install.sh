#!/bin/bash -i

set -e

MODELS=${MODELS:-undefined}

# Checks if packages are installed and installs them if not
check_packages() {
	if ! dpkg -s "$@" >/dev/null 2>&1; then
		if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
			echo "Running apt-get update..."
			apt-get update -y
		fi
		apt-get -y install --no-install-recommends "$@"
	fi
}

# make sure we have curl
check_packages ca-certificates curl

curl https://ollama.ai/install.sh | sh

mkdir -p "/usr/local/share/ollama/"

cat <<EOF > /usr/local/share/ollama/oncreate.sh
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
