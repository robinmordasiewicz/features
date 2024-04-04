#!/bin/bash
#

set -e

MODULES=${MODULES:-undefined}
echo "#!/usr/local/bin/pwsh -NoProfile" > /tmp/modules.ps1

IFS=','
for mod in ${MODULES}; do
  #pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
  #pwsh -NoProfile -noni -Command "& {Install-Module -Name ${mod} -AllowClobber -Force -Scope AllUsers}" || continue
  echo "Install-Module -Name ${mod} -AllowClobber -Force -Scope AllUsers" >> /tmp/modules.ps1
done
chmod 755 /tmp/modules.ps1
/tmp/modules.ps1

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

#if [ -n "${POWERSHELL_PROFILE_URL}" ]; then
#  profilePath=$(pwsh -noni -Command '$PROFILE.AllUsersAllHosts')
#  if [ ! -f "${profilePath}" ]; then
#    curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}" || exit 0
#  fi
#fi
