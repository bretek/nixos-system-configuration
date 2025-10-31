{ ... }:
{
  imports = [
    ../../configuration.nix
    ./drives
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  system-options = {
    name = "nixos-laptop";
    isLaptop = true;
  };

  home-manager.users.joseph = {
    home.stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}
