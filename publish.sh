#!/bin/sh
cd ../
eval "$@"
set -o errexit
set -o nounset

IFS=$(printf '\n\t')

# Docker
git pull
docker system prune -f --volumes
sudo docker build -t coreapp .
sudo docker-compose down
sudo docker-compose up -d




