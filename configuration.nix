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

  # BOOT
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.gamemode.enable = true;
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

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
  };

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
    protonplus
    wineWowPackages.stable
    winetricks

    git
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
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  security.polkit.enable = true;

  powerManagement.enable = true;

    };
  };

  system.copySystemConfiguration = true;
}
