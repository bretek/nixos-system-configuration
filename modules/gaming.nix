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

  #  nixpkgs.config.packageOverrides = pkgs: {
  #    steam = pkgs.steam.override {
  #      extraPkgs =
  #        pkgs: with pkgs; [
  #          harfbuzz
  #          libthai
  #          pango
  #          tree
  #          wget
  #          xdotool
  #          xorg.xrandr
  #          xxd
  #          yad
  #        ];
  #      privateTmp = false;
  #    };
  #  };

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
