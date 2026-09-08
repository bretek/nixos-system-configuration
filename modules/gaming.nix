{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonplus
    steamtinkerlaunch
    lutris
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
      #global_prep_cmd = "[{ \"do\" : \"sh -c \\\"hyprctl keyword monitor HEADLESS-2,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1 && hyprctl keyword monitor DP-1,mirror,HEADLESS-2\\\"\", \"undo\" : \"sh -c \\\"hyprctl keyword monitor DP-1,3840x1600@144,0x0,1 && hyprctl keyword monitor HEADLESS-2,disable\\\"\" }]";
      #global_prep_cmd = "[{ \"do\" : \"sh -c \\\"hyprctl keyword monitor HEADLESS-2,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1 && hyprctl keyword monitor DP-1,disable\\\"\", \"undo\" : \"sh -c \\\"hyprctl keyword monitor DP-1,3840x1600@144,0x0,1 && hyprctl keyword monitor HEADLESS-2,disable\\\"\" }]";
      capture = "wlr";
    };
    #applications = {
    #  apps = [
    #    {
    #      name = "Steam";
    #      prep-cmd = [
    #        {
    #          do = "sh -c \"setsid steam steam://close/bigpicture && hyprctl keyword monitor HEADLESS-2,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1 && hyprctl keyword monitor DP-1,mirror,HEADLESS-2\"";
    #          undo = "sh -c \"setsid steam steam://close/bigpicture && hyprctl keyword monitor DP-1,3840x1600@144,0x0,1 && hyprctl keyword monitor HEADLESS-2,disable\"";
    #        }
    #      ];
    #      detached-command = "setsid steam steam://close/bigpicture";
    #      image = "steam.png";
    #      auto-detach = "true";
    #    }
    #  ];
    #};
  };

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
