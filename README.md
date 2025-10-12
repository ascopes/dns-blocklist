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

## Schedule

This rebuilds every 6 hours.

## Output

The output is at `https://ascopes.github.io/dns-blocklist/blocklist.txt`.

## Can you provide this in other formats?

No.

## I want to include a change

This repo is primarily for my own use. Feel free to fork it and configure it with
what you need. I will not be accepting pull requests.
