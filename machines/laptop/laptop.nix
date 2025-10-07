{ ... }:
{
  imports = [
    ../../configuration.nix
    ./drives
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  home-manager.users.joseph = {
    home.stateVersion = "23.11";
  };

  system.stateVersion = "23.11";
}
