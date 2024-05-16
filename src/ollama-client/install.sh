#!/bin/bash
set -eu

TEMP_DIR=$(mktemp -d)
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *) error "Unsupported architecture: $ARCH" ;;
esac

curl --fail --show-error --location --progress-bar -o $TEMP_DIR/ollama "https://ollama.com/download/ollama-linux-${ARCH}"

for BINDIR in /usr/local/bin /usr/bin /bin; do
  echo $PATH | grep -q $BINDIR && break || continue
done

install -o0 -g0 -m755 -d $BINDIR
install -o0 -g0 -m755 $TEMP_DIR/ollama $BINDIR/ollama
