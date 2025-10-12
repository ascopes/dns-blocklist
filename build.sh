#!/usr/bin/env bash
set -eu

echo "Ensuring tooling is installed..."
if ! command -v hostlist-compiler &> /dev/null; then
  npm i -g @adguard/hostlist-compiler
fi

# Set the version number in the config.
echo "Configuring version in config..."
jq '. * {version: $version}' config.json \
    --arg version "$(date +'%y.%m.%d.%H%M%S')" \
    > config.json.new
mv config.json{.new,}

# Compile the lists
echo "Compiling the lists..."
mkdir -p out/

cmd=(
  hostlist-compiler 
  --config=config.json
  --output=out/blocklist.txt
)

if [[ -v DEBUG ]]; then
  cmd+=(--verbose)
fi

"${cmd[@]}"
