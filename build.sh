#!/usr/bin/env bash

cd $(dirname $0)

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
machine_path=${2:-'machines/desktop/desktop.nix'}
as_sudo=${3:-1}
shift 3

run_as="sudo"
if [[ as_sudo -eq 0 ]]
then
    run_as=""
fi

./nix-prefetch.sh

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs --extra-experimental-features nix-command)
echo $nixpkgs_pin
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/${machine_path}"

# without --no-reexec, nixos-rebuild will compile nix and use the compiled nix to
# evaluate the config, wasting several seconds
$run_as env NIX_PATH="${nix_path}" nixos-rebuild "$cmd" --no-reexec "$@"
