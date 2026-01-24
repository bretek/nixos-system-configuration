{ config, pkgs, ... }:
{
  allowedUnfree = [
    "displaylink"
  ];

  services.xserver.videoDrivers = [
    "displaylink"
    "modesetting"
  ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd = {
      # List of modules that are always loaded by the initrd.
      kernelModules = [
        "evdi"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    displaylink
  ];
}
