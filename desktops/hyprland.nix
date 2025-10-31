{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wdisplays
    swayimg
    rofi-wayland
    brillo
    dunst
    hyprpaper
    wlogout
    waybar
    hypridle
    hyprlock
    playerctl
    wayland-pipewire-idle-inhibit

    wayprompt
    kooha
    wob
    cliphist
    grim
  ];

  hardware.brillo.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
