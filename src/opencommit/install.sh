#!/bin/bash
set -ex

directory="/tmp/opencommit"
old_string="http://localhost:11434/api/chat"
new_string="https://www.bankexample.com/api/chat"

if [ -d "${directory}" ]; then
  rm -rf "${directory}"
fi
git clone https://github.com/di-sukharev/opencommit.git "${directory}"

cd "${directory}"
find . -type f -print0 | while IFS= read -r -d '' file; do
  if grep -q "${old_string}" "${file}"; then
    echo "${file}" && sed "s|${old_string}|${new_string}|g" "${file}" >"${file}.tmp" && mv -f "${file}.tmp" "${file}"
  fi
done

# sudo env "NVM_DIR=$HOME/.nvm" "NVM_BIN=/usr/local/bin/" ./src/opencommit/install.sh

. "$NVM_DIR/nvm.sh" && "${NVM_BIN}"/npm uninstall -g opencommit
cd "${directory}"
npm pack
version=$(jq -r .version package.json)
cd "${directory}" && . "${NVM_DIR}/nvm.sh" && "${NVM_BIN}"/npm install opencommit-"${version}".tgz --no-save -g
cd -
rm -rf "${directory}"
