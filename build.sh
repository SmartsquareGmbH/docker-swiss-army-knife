#!/usr/bin/env bash
set -euo pipefail 

docker build -t ghcr.io/smartsquaregmbh/swiss-army-knife:privileged --target privileged . 
docker build -t ghcr.io/smartsquaregmbh/swiss-army-knife:unprivileged --target unprivileged .