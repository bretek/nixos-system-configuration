{ ... }:
{
  imports = [
    ../../configuration.nix
    ./drives
    ./gpu.nix
    ./hardware-configuration.nix
  ];
}
