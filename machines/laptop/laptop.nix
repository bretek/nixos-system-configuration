{ ... }:
{
  imports = [
    ../../configuration.nix
    ./drives
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";
}
