{ pkgs, ... }:
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
    monitors = "DP-1, 3840x1600@144, 0x0, 1";
    kernelVersion = pkgs.linuxPackages_7_2;
  };

  home-manager.users.joseph = {
    home.stateVersion = "25.11";
  };

  system.stateVersion = "25.11";
}
