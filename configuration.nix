{ pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  home-manager = sources.home-manager;
  agenix = sources.agenix;
in
{
  imports = [
    ./desktops/default.nix
    ./modules
    ./overlays
    ./users
    (home-manager + "/nixos")
    (agenix + "/modules/age.nix")
  ];

  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  security.polkit.enable = true;
  powerManagement.enable = true;
  home-manager.useGlobalPkgs = true;

  # NETWORKING
  networking = {
    hostName = "NixDesktop";
    networkmanager.enable = true;
  };

  # FONTS
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.inter
      pkgs.nerd-fonts.fira-code
    ];
    fontconfig.defaultFonts = {
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      monospace = [ "FiraCode Nerd Font Mono" ];
    };
  };

  # APPS
  environment.systemPackages = with pkgs; [
    firefox-wayland
    libreoffice-qt
    vlc

    protonplus
    wineWowPackages.stable
    winetricks

    unzip
    (pkgs.callPackage (agenix + "/pkgs/agenix.nix") { })
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"

      "xow_dongle-firmware"
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          pango
          libthai
          harfbuzz
        ];
      privateTmp = false;
    };
  };
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
