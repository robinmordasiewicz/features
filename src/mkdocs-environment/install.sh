#!/bin/bash
set -e

echo "Activating feature 'mkdocs conda environment'"

WORKINGDIR=$(pwd)
su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && /opt/conda/bin/conda env create -f ${WORKINGDIR}/mkdocs-environment.yml"
