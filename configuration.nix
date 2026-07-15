{
  config,
  lib,
  pkgs,
  ...
}:
let
  sources = import ./npins;
in
{
  imports = [
    ./desktops
    ./modules
    ./options/allowed-unfree.nix
    ./options/system-options.nix
    ./overlays
    ./secrets/configuration.nix
    ./users
    (sources.home-manager + "/nixos")
    (sources.agenix + "/modules/age.nix")
  ];

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.allowedUnfree;
    permittedInsecurePackages = pkg: builtins.elem (lib.getName pkg) config.permittedInsecure;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_7_0;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  security.polkit.enable = true;
  powerManagement.enable = true;
  home-manager.useGlobalPkgs = true;

  # NETWORKING
  networking = {
    hostName = config.system-options.name;
    networkmanager = {
      enable = true;
      wifi.powersave = config.system-options.isLaptop;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };
  environment.etc.hosts.mode = "0755";

  # FONTS
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.inter
      pkgs.fira-mono
      pkgs.nerd-fonts.symbols-only

      pkgs.lato
    ];
    fontconfig.defaultFonts = {
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      monospace = [ "Fira Mono" ];
    };
  };

  # APPS
  environment.systemPackages = with pkgs; [
    # Basic apps
    firefox-bin
    libreoffice-qt
    snapshot
    vlc
    gnome-calculator

    # Compatibility tools
    wineWow64Packages.stable
    winetricks

    # Basic CLI utils
    unzip
    npins
    (pkgs.callPackage (sources.agenix + "/pkgs/agenix.nix") { })
    vim
  ];

  allowedUnfree = [
    "terraform"
    "xone-dongle-firmware"
    "firefox-bin"
    "firefox-bin-unwrapped"
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = if config.system-options.driveFormat == "btrfs" then "btrfs" else null;
  };
  users.extraGroups.docker.members = [ "joseph" ];
  users.extraGroups.dialout.members = [ "joseph" ];
}
