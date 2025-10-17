#!/usr/bin/env bash
set -o errexit
set -o nounset
[[ -v DEBUG ]] && set -o xtrace

echo "Ensuring tooling is installed..."
command -v hostlist-compiler &> /dev/null \
    || npm install -g @adguard/hostlist-compiler

# Set the version number in the config.
version=$(date +'%y.%m.%d.%H%M%S')
echo "Configuring version in config to be ${version}..."
jq '. * {version: $version}' config.json --arg version "${version}" > config.json.new
mv -v config.json{.new,}

# Compile the lists
echo "Compiling the lists..."
mkdir -p out/

cmd=(hostlist-compiler --config=config.json --output=out/blocklist.txt)
[[ -v DEBUG ]] && cmd+=(--verbose)
"${cmd[@]}"
