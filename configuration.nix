{ pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  home-manager = sources.home-manager;
  agenix = sources.agenix;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      xow_dongle-firmware = prev.xow_dongle-firmware.overrideAttrs (old: {
        installPhase = ''
          install -Dm644 xow_dongle.bin $out/lib/firmware/xow_dongle.bin
          ln $out/lib/firmware/xow_dongle.bin $out/lib/firmware/xow_dongle_045e_02fe.bin
          install -Dm644 xow_dongle_045e_02e6.bin $out/lib/firmware/xow_dongle_045e_02e6.bin
        '';
      });
    })
  ];

  imports = [
    ./nixos.nix
    ./desktops/default.nix
    ./secure-boot.nix
    ./steam-stream.nix
    ./users
    (home-manager + "/nixos")
    (agenix + "/modules/age.nix")
  ];

  # BOOT
  boot.initrd.systemd.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
  programs.tuxclocker.enable = true;
  hardware = {
    # HARDWARE
    bluetooth.enable = true;
    steam-hardware.enable = true;
    xone.enable = true;
    usb-modeswitch.enable = true;

    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
      enable = true;
      enable32Bit = true;
    };

  };

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

  # SERVICES
  powerManagement.enable = true;

  services = {
    pipewire.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    fail2ban.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "joseph" ];
      };
    };
    dbus.enable = true;
  };

  system.copySystemConfiguration = true;
  system.stateVersion = "25.05";
}
