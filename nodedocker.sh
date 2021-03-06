#!/bin/sh

set -o errexit
set -o nounset

IFS=$(printf '\n\t')

# Nodejs
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
	&& sudo apt install nodejs \
	&& printf '\nNodejs installed successfully\n\n'

# Docker
sudo apt remove --yes docker docker-engine docker.io containerd runc \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
    && wget --quiet --output-document=- https://download.docker.com/linux/ubuntu/gpg \
        | sudo apt-key add - \
    && sudo add-apt-repository \
        "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
        $(lsb_release --codename --short) \
        stable" \
    && sudo apt update \
    && sudo apt --yes --no-install-recommends install docker-ce docker-ce-cli containerd.io \
    && sudo usermod --append --groups docker "$USER" \
    && sudo systemctl enable docker \
    && printf '\nDocker installed successfully\n\n'

printf 'Waiting for Docker to start...\n\n'
sleep 3

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
	&& sudo chmod +x /usr/local/bin/docker-compose \
	&& printf '\nDocker Compose installed successfully\n\n'
