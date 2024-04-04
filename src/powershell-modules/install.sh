#!/bin/bash
#

set -e

MODULES=${MODULES:-undefined}

IFS=','
for mod in ${MODULES}; do
  pwsh -NoProfile -noni -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
done

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

if [ -n "$POWERSHELL_PROFILE_URL" ]; then
    profilePath=$(pwsh -noni -Command '$PROFILE.AllUsersAllHosts')
    curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}" || continue
fi
