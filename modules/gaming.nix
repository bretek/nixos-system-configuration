{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonplus
    steamtinkerlaunch
  ];

  allowedUnfree = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    settings = {
      global_prep_cmd = "[{ \"do\" : \"sh -c \\\"hyprctl keyword monitor HEADLESS-2,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1 && hyprctl keyword monitor DP-1,disable\\\"\", \"undo\" : \"sh -c \\\"hyprctl keyword monitor DP-1,3840x1600@144,0x0,1 && hyprctl keyword monitor HEADLESS-2,disable\\\"\" }]";
      capture = "wlr";
    };
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
