#!/bin/bash
#

set -e

MODULES=${MODULES:-undefined}
echo "#!/opt/microsoft/powershell/7/pwsh -NoProfile" > /tmp/modules.ps1
echo "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted" >> /tmp/modules.ps1
pwsh -NoProfile -Command '& {Set-PSRepository -Name PSGallery -InstallationPolicy Trusted'
pwsh -NoProfile -Command '& {Install-Module -Name z -Repository PSGallery -AllowClobber -Scope AllUsers}'
pwsh -NoProfile -Command '& {Install-Module -Name Terminal-Icons -Repository PSGallery -AllowClobber -Scope AllUsers}'
pwsh -NoProfile -Command '& {Install-Module -Name PowerShellAI -Repository PSGallery -AllowClobber -Scope AllUsers}'

IFS=','
for mod in ${MODULES}; do
  #pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
  #pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -AllowClobber -Force -Scope AllUsers}" || continue
  echo "Install-Module -Name ${mod} -AllowClobber -Scope AllUsers" >> /tmp/modules.ps1
done
chmod 755 /tmp/modules.ps1
#/tmp/modules.ps1

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

#if [ -n "${POWERSHELL_PROFILE_URL}" ]; then
#  profilePath=$(pwsh -noni -Command '$PROFILE.AllUsersAllHosts')
#  if [ ! -f "${profilePath}" ]; then
#    curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}" || exit 0
#  fi
#fi
