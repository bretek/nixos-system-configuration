#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p nixos-rebuild cacert

cd $(dirname $0)/..
as_sudo=0
machine_path=$1
./build.sh build $machine_path $as_sudo
