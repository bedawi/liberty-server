#!/bin/bash
# This script downloads the current mautrix-telegram sources
# and compiles a container-image called "mautrix-telegram-custom"
git clone https://github.com/tulir/mautrix-telegram.git
cd mautrix-telegram/
docker build -t mautrix-telegram-custom .
