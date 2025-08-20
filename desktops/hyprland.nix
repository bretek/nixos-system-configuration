{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wdisplays
    swayimg
    rofi-wayland
    dunst
    hyprpaper
    wlogout
    waybar
    hypridle
    hyprlock
    wayland-pipewire-idle-inhibit

    wayprompt
    kooha
    wob
    cliphist
    grim
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
