{ pkgs, ... }:
{
  imports = [
    ./plugins.nix
  ];

  home.packages = with pkgs; [
    ardour

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wineWow64Packages.stable
  ];
}
