#!/bin/bash
set -e

WORKINGDIR=$(pwd)
su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && /opt/conda/bin/conda env create -f ${WORKINGDIR}/environment.yml"
