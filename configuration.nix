{
  config,
  lib,
  ...
}:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.allowedUnfree;
  };
  home-manager = sources.home-manager;
  agenix = sources.agenix;
in
{
  imports = [
    ./desktops/default.nix
    ./modules
    ./options/allowed-unfree.nix
    ./options/system-options.nix
    ./overlays
    ./secrets/configuration.nix
    ./users
    (home-manager + "/nixos")
    (agenix + "/modules/age.nix")
  ];

  nixpkgs.pkgs = pkgs;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    firefox
    libreoffice-qt
    vlc

    wineWowPackages.stable
    winetricks

    unzip
    (pkgs.callPackage (agenix + "/pkgs/agenix.nix") { })
  ];

  allowedUnfree = [
    "terraform"
    "xow_dongle-firmware"
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };
  users.extraGroups.docker.members = [ "joseph" ];
}
