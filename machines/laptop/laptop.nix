{ ... }:
{
  imports = [
    ../../configuration.nix
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";
}
