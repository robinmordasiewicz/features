#!/bin/env bash
set -e

MODULES=${MODULES:-undefined}

IFS=',' read -ra MODULES_ARRAY <<<"$MODULES"

for mod in "${MODULES_ARRAY[@]}"; do
  pwsh -NoProfile -NonInteractive -Command "Install-Module -Name $mod -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
done

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

# If URL for powershell profile is provided, download it to '/opt/microsoft/powershell/7/profile.ps1'
if [ -n "$POWERSHELL_PROFILE_URL" ]; then
    echo "Downloading PowerShell Profile from: $POWERSHELL_PROFILE_URL"
    # Get profile path from currently installed pwsh
    profilePath=$(pwsh -noni -c '$PROFILE.AllUsersAllHosts')
    sudo -E curl -sSL -o "$profilePath" "$POWERSHELL_PROFILE_URL"
fi
