#!/bin/bash
#

sudo -H -u postgres sh -c "psql -f /tmp/initmemgpt.sql"
