#!/usr/bin/env bash
set -o errexit
set -o nounset
[[ -v DEBUG ]] && set -o xtrace

echo "Ensuring tooling is installed..."
command -v hostlist-compiler &> /dev/null || npm install -g @adguard/hostlist-compiler

# Translate the YAML config into JSON
yq . config.yml -o json > config.json

# Set the version number in the config from the date and commit digest.
version="$(date +'%y.%m.%d.%H%M%S')+$(git rev-parse --short HEAD)"
echo "Configuring version in config to be ${version}..."
jq '. * {version: $version}' config.json --arg version "${version}" > config.json.new
mv -v config.json{.new,}

# Compile the lists
echo "Compiling the lists..."
mkdir -p out/
cmd=(hostlist-compiler --config=config.json --output=out/blocklist.txt)
[[ -v DEBUG ]] && cmd+=(--verbose)
"${cmd[@]}"

echo "Generating badges..."

# Count the non comment lines, comma-separate thousands to make it easier to read.
entry_count=$(grep -cvE '^( *)([#!;].*)?$' out/blocklist.txt | sed -E ':a;s/([0-9])([0-9]{3})($|[^0-9])/\1,\2\3/;ta')
curl -sSLo out/entry-count-badge.svg "https://img.shields.io/badge/${entry_count}-blue?label=Compressed%20Entries"

build_date=$(date | sed 's/-/--/g')
curl -sSLo out/last-built-at-badge.svg "https://img.shields.io/badge/${build_date}-orange?label=Last%20Built%29At"
