#!/bin/bash
#

set -e

MODULES=${MODULES:-undefined}

if [ ! -d "/usr/local/share/powershell-modules/" ]; then
  mkdir -p "/usr/local/share/powershell-modules/"
fi

sudo apt-get update &&
  sudo apt-get install -y dotnet-sdk-8.0

echo "#!/opt/microsoft/powershell/7/pwsh -NoProfile" >/usr/local/share/powershell-modules/modules.ps1

echo "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12" >/usr/local/share/powershell-modules/modules.ps1
echo "Register-PSRepository -Default -Verbose" >>/usr/local/share/powershell-modules/modules.ps1
echo "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -SourceLocation 'https://www.powershellgallery.com/api/v2'" >>/usr/local/share/powershell-modules/modules.ps1
#pwsh -NoProfile -Command '& {Set-PSRepository -Name PSGallery -InstallationPolicy Trusted'
#pwsh -NoProfile -Command '& {Install-Module -Name z -Repository PSGallery -AllowClobber -Scope AllUsers}'
#pwsh -NoProfile -Command '& {Install-Module -Name Terminal-Icons -Repository PSGallery -AllowClobber -Scope AllUsers}'
#pwsh -NoProfile -Command '& {Install-Module -Name PowerShellAI -Repository PSGallery -AllowClobber -Scope AllUsers}'

IFS=','
for mod in ${MODULES}; do
  #pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
  #pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -AllowClobber -Force -Scope AllUsers}" || continue
  echo "Install-Module -Name ${mod} -AllowClobber -Scope AllUsers -Force" >>/usr/local/share/powershell-modules/modules.ps1
  #echo "Get-InstalledModule" >>/usr/local/share/powershell-modules/modules.ps1
done

chmod 755 /usr/local/share/powershell-modules/modules.ps1
#/opt/microsoft/powershell/7/pwsh -nop -noni -command . "/usr/local/share/powershell-modules/modules.ps1"

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

if [ -n "${POWERSHELL_PROFILE_URL}" ]; then
  profilePath=$(pwsh -NoProfile -Command '$PROFILE.AllUsersAllHosts')
  curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}"
fi
