#!/usr/bin/env bash
set -euo pipefail 

docker build -t swiss-army-knife:privileged --target privileged . 
docker build -t swiss-army-knife:unprivileged --target unprivileged .