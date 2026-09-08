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

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
