#!/bin/bash
set -e

MODULES=${MODULES:-undefined}
echo "${MODULES}" > /tmp/powershell.txt

IFS=','
for mod in ${MODULES}; do
  pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
done

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

if [ -n "$POWERSHELL_PROFILE_URL" ]; then
    echo "Downloading PowerShell Profile from: ${POWERSHELL_PROFILE_URL}"
    profilePath=$(pwsh -noni -c '$PROFILE.AllUsersAllHosts')
    sudo -E curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}" || continue
fi
