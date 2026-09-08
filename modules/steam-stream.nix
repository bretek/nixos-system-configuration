{ pkgs, ... }:
let
  steamos-session-select = pkgs.writeShellApplication {
    name = "steamos-session-select";
    text = ''
      #!/usr/bin/env sh
      steam -shutdown
    '';
  };
in
{
  environment.systemPackages = [
    steamos-session-select
  ];

  programs.gamescope = {
    enable = true;
    #capSysNice = true;
    args = [
      "--rt"
      "--adaptive-sync"
      "--steam"
      "--backend headless"
    ];
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "--rt"
      "--adaptive-sync"
      "--steam"
    ];
    gamescopeSession.steamArgs = [
      "-tenfoot"
      "-pipewire-dmabuf"
      #"-steamdeck"
      #"-steamos3"
    ];
    localNetworkGameTransfers.openFirewall = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    settings = {
      #global_prep_cmd = "[{ \"do\" : \"sh -c \\\"hyprctl keyword monitor HEADLESS-2,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1 && hyprctl keyword monitor DP-1,disable\\\"\", \"undo\" : \"sh -c \\\"hyprctl keyword monitor DP-1,3840x1600@144,0x0,1 && hyprctl keyword monitor HEADLESS-2,disable\\\"\" }]";
      #capture = "wlr";
    };
  };

  allowedUnfree = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];

  programs.gamemode.enable = true;
}
