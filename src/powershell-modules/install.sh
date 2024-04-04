#!/bin/bash
set -e

MODULES=${MODULES:-undefined}
echo "${MODULES}" > /tmp/powershell.txt

echo '#!/usr/local/bin/pwsh -NoProfile -NonInteractive' > /tmp/modules.ps1

#IFS=',' read -ra MODULES <<<"${MODULES}"
#for mod in "${MODULES[@]}"; do
IFS=','
for mod in "${MODULES}"; do
  #pwsh -NoProfile -NonInteractive -Command ("Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers") || continue
  #pwsh -NoProfile -NonInteractive -CommandWithArgs "Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
  pwsh -NoProfile -Command "& {Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers}" || continue
  echo "Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers" >> /tmp/modules.ps1
done

chmod 755 /tmp/modules.ps1
#/tmp/modules.ps1
#rm /tmp/modules.ps1

#MODULES=${MODULES:-""}
#IFS=, read -ra MODULES <<< "${MODULES}"
#for mod in "${MODULES[@]}"
#do
#  pwsh -NoProfile -NonInteractive -Command "Install-Module -Name ${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
#  echo "sudo -n pwsh -NoProfile -NonInteractive -Command \"Install-Module -Name \${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers\" || continue"
#done

POWERSHELL_PROFILE_URL="${POWERSHELLPROFILEURL}"
# If URL for powershell profile is provided, download it to '/opt/microsoft/powershell/7/profile.ps1'
if [ -n "$POWERSHELL_PROFILE_URL" ]; then
    echo "Downloading PowerShell Profile from: ${POWERSHELL_PROFILE_URL}"
    # Get profile path from currently installed pwsh
    profilePath=$(pwsh -noni -c '$PROFILE.AllUsersAllHosts')
    sudo -E curl -sSL -o "${profilePath}" "${POWERSHELL_PROFILE_URL}"
fi

if [ ! -d /usr/local/share/powershell-modules ];then
  mkdir -p "/usr/local/share/powershell-modules/"
fi

cat <<EOF >/usr/local/share/powershell-modules/oncreate.sh
#!/bin/bash
set -e

MODULES="${MODULES}"

#IFS=, read -ra MODULES <<< "\${MODULES}"
#for mod in "\${MODULES[@]}"
IFS=','
for mod in "${MODULES}"; do
do
  #sudo -n pwsh -NoProfile -NonInteractive -Command "Install-Module -Name \${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
  echo "sudo -n pwsh -NoProfile -NonInteractive -Command \"Install-Module -Name \${mod} -Repository PSGallery -AllowClobber -Force -Scope AllUsers\" || continue"
done
exit 0
EOF

chmod 755 /usr/local/share/powershell-modules/oncreate.sh
