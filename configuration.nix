{ pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
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
    ./hardware-configuration.nix
    ./steam-stream.nix
    ./users
    lanzaboote.nixosModules.lanzaboote
    (home-manager + "/nixos")
    (agenix + "/modules/age.nix")
  ];

  # BOOT
  boot.initrd.systemd.enable = true;
  #boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [
    "nfs"
    "btrfs"
  ];

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

  fileSystems."/".options = [ "noatime" ];

  # NFS
  fileSystems."/mnt/media" = {
    device = "nas.mad.internal:/media";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "noatime"
    ];
  };
  fileSystems."/mnt/nas" = {
    device = "nas.mad.internal:/nas";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "noatime"
    ];
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

  #hardware.graphics.extraPackages = with pkgs; [
  #  amdvlk
  #];
  # For 32 bit applications
  #hardware.graphics.extraPackages32 = with pkgs; [
  #  driversi686Linux.amdvlk
  #];

  # DRIVES
  fileSystems."/mnt/NVME" = {
    device = "/dev/disk/by-uuid/ffb2fa16-885d-4ff2-9c8b-78d9682107cf";
    fsType = "btrfs";
    options = [
      "nofail"
    ];
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
    oversteer
    wineWowPackages.stable
    winetricks
    steamtinkerlaunch

    git
    unzip
    wget
    xdotool
    xxd
    xorg.xwininfo
    yad
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
  security.sudo.extraRules = [
    {
      users = [ "joseph" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nix-store";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

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
