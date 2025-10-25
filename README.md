# DNS blocklists

A pipeline to compile and deduplicate any DNS blocklists I use with
AdGuard Home. This helps me avoid choking my Raspberry Pi 3B by trying
to compile and deduplicate these rules locally, given the tight memory
constraints that I have to work with.

Should also be compatible with Pihole.

## Why GitHub Actions?

It is the easiest way to build this for free without having a dedicated computer
with enough memory set up.

## Licenses

Each block list is subject to the licenses presented in their license header,
and the output of this pipeline is not covered by the license in this repository.

## Exclusions

I exclude some domains to keep stuff that I or other people use working properly. This includes
Smart TVs and some commonly used websites that are flagged as false positives. Those
are listed in the various `exclusions-*.txt` files.

## Schedule

This rebuilds every 24 hours.

## Output

The output is at `https://ascopes.github.io/dns-blocklist/blocklist.txt`.

## Config syntax

I use YAML to encode the config, but during compilation it will be encoded as JSON. YAML is used
to allow more sensible formatting and comments if I need to add them.

The configuration schema is documented at https://github.com/AdguardTeam/HostlistCompiler.

## Can you provide this in other formats?

No.

## I want to include a change

This repo is primarily for my own use. Feel free to fork it and configure it with
what you need. I will not be accepting pull requests.
