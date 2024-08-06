#!/bin/bash
set -ex

directory="/tmp/opencommit"
old_url="http://localhost:11434/api/chat"
new_url="http://www.bankexample.com:80/api/chat"
old_model="mistral"
new_model="codestral"

if [ -d "${directory}" ]; then
  rm -rf "${directory}"
fi
git clone https://github.com/di-sukharev/opencommit.git "${directory}"

cd "${directory}"
find . -type f -print0 | while IFS= read -r -d '' file; do
  if grep -q "${old_url}" "${file}"; then
    echo "${file}" && sed "s|${old_url}|${new_url}|g" "${file}" >"${file}.tmp" && mv -f "${file}.tmp" "${file}"
  fi
done

find . -type f -print0 | while IFS= read -r -d '' file; do
  if grep -q "${old_model}" "${file}"; then
    echo "${file}" && sed "s|${old_model}|${new_model}|g" "${file}" >"${file}.tmp" && mv -f "${file}.tmp" "${file}"
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
