{ ... }:
{
  imports = [
    ../../configuration.nix
    ../../modules/syncthing.nix
    ./drives
    ./gpu.nix
    ./hardware-configuration.nix
  ];

  system-options = {
    name = "nixos-desktop";
    isLaptop = false;
    driveFormat = "btrfs";
  };

  home-manager.users.joseph = {
    home.stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}
