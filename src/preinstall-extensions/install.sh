#!/bin/env bash
set -e

EXTENSIONS=${EXTENSIONS:-undefined}

get_latest_release() {
    tag=$(curl --silent "https://api.github.com/repos/${1}/releases/latest" | # Get latest release from GitHub API
          grep '"tag_name":'                                              | # Get tag line
          sed -E 's/.*"([^"]+)".*/\1/'                                    ) # Pluck JSON value

    tag_data=$(curl --silent "https://api.github.com/repos/${1}/git/ref/tags/${tag}")

    sha=$(echo "${tag_data}"           | # Get latest release from GitHub API
          grep '"sha":'                | # Get tag line
          sed -E 's/.*"([^"]+)".*/\1/' ) # Pluck JSON value

    sha_type=$(echo "${tag_data}"           | # Get latest release from GitHub API
          grep '"type":'                    | # Get tag line
          sed -E 's/.*"([^"]+)".*/\1/'      ) # Pluck JSON value

    if [ "${sha_type}" != "commit" ]; then
        combo_sha=$(curl -s "https://api.github.com/repos/${1}/git/tags/${sha}" | # Get latest release from GitHub API
              grep '"sha":'                                                     | # Get tag line
              sed -E 's/.*"([^"]+)".*/\1/'                                      ) # Pluck JSON value

        # Remove the tag sha, leaving only the commit sha;
        # this won't work if there are ever more than 2 sha,
        # and use xargs to remove whitespace/newline.
        sha=$(echo "${combo_sha}" | sed -E "s/${sha}//" | xargs)
    fi

    printf "${sha}"
}

ARCH="x64"
U_NAME=$(uname -m)

if [ "${U_NAME}" = "aarch64" ]; then
    ARCH="arm64"
fi

archive="vscode-server-linux-${ARCH}.tar.gz"
owner='microsoft'
repo='vscode'
vscode_commit_sha=$(get_latest_release "${owner}/${repo}")

vscode_dir="/tmp/.vscode/"
if [ ! -d  ${vscode_dir} ]; then
    su -l $_REMOTE_USER -c "mkdir -p ${vscode_dir}"
fi

curl -s -L "https://update.code.visualstudio.com/commit:${vscode_commit_sha}/server-linux-${ARCH}/stable" -o "/tmp/${archive}"

tar --no-same-owner -xz --strip-components=1 -C "$vscode_dir" -f "/tmp/${archive}"

if [ ! -d  $_REMOTE_USER_HOME/.vscode-server/extensions ]; then
    su -l $_REMOTE_USER -c "mkdir -p $_REMOTE_USER_HOME/.vscode-server/extensions"
fi

IFS=',' read -ra EXTENSIONS_ARRAY <<< "$EXTENSIONS"

for ext in "${EXTENSIONS_ARRAY[@]}"; do
    su -l $_REMOTE_USER -c "$vscode_dir/bin/code-server --install-extension $ext --extensions-dir $_REMOTE_USER_HOME/.vscode-server/extensions"
done

rm -rd "$vscode_dir"
rm "/tmp/${archive}"
