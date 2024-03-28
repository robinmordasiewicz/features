#!/bin/bash
set -e

su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && yes y | /opt/conda/bin/conda update --all"
su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && yes y | /opt/conda/bin/conda update -n base -c conda-forge conda --repodata-fn=repodata.json"
su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && yes y | /opt/conda/bin/conda update -n base -c defaults conda --repodata-fn=repodata.json"
