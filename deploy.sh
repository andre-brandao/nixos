#!/usr/bin/env bash
export NIX_SSHOPTS="-A"

build_remote=false

hosts=""
shift

if [ -z "$hosts" ]; then
    echo "No hosts to deploy"
    exit 2
fi

for host in ${hosts//,/ }; do
    nixos-rebuild --flake .\#pve-vault switch --target-host 192.168.0.172 --use-remote-sudo
done
