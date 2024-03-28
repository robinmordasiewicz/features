#!/bin/bash
set -e

echo "Activating feature 'openwebui conda environment'"

WORKINGDIR=$(pwd)
su -l vscode -c "source /opt/conda/etc/profile.d/conda.sh && /opt/conda/bin/conda env create -f ${WORKINGDIR}/openwebui.yml"
