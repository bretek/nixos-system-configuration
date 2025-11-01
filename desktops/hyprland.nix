{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brillo
    cliphist
    dunst
    hypridle
    hyprlock
    hyprpaper
    playerctl
    rofi-wayland
    swayimg
    waybar
    wayland-pipewire-idle-inhibit
    wayprompt
    wdisplays
    wlogout

    kooha
    wob
    grim
  ];

  hardware.brillo.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
