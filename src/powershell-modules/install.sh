#!/bin/env bash
set -e

POWERSHELL_MODULES="${MODULES:-""}"
POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"

# If PowerShell modules are requested, loop through and install
if [ ${#POWERSHELL_MODULES[@]} -gt 0 ]; then
    echo "Installing PowerShell Modules: ${POWERSHELL_MODULES}"
    modules=(`echo ${POWERSHELL_MODULES} | tr ',' ' '`)
    for i in "${modules[@]}"
    do
        echo "Installing ${i}"
        pwsh -NoProfile -NonInteractive -Command "Install-Module -Name ${i} -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
        echo "pwsh -NoProfile -NonInteractive -Command \"Install-Module -Name ${i} -Repository PSGallery -AllowClobber -Force -Scope AllUsers\" || continue"
    done
fi

# If URL for powershell profile is provided, download it to '/opt/microsoft/powershell/7/profile.ps1'
if [ -n "$POWERSHELL_PROFILE_URL" ]; then
    echo "Downloading PowerShell Profile from: $POWERSHELL_PROFILE_URL"
    # Get profile path from currently installed pwsh
    profilePath=$(pwsh -noni -c '$PROFILE.AllUsersAllHosts')
    sudo -E curl -sSL -o "$profilePath" "$POWERSHELL_PROFILE_URL"
fi

if [ ! -d /usr/local/share/powershell-modules ];then
  mkdir -p "/usr/local/share/powershell-modules/"
fi

cat <<EOF >/usr/local/share/powershell-modules/oncreate.sh
#!/bin/env bash
set -e

MODULES="${POWERSHELL_MODULES}"
IFS=','
for mod in "\${MODULES}"; do
  #sudo -n pwsh -NoProfile -NonInteractive -Command "Install-Module -Name $mod -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
  echo "sudo -n pwsh -NoProfile -NonInteractive -Command \"Install-Module -Name $mod -Repository PSGallery -AllowClobber -Force -Scope AllUsers\" || continue"
done
exit 0
EOF

chmod 755 /usr/local/share/powershell-modules/oncreate.sh
