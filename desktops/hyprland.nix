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
    rofi
    swayimg
    waybar
    wayland-pipewire-idle-inhibit
    wayprompt
    wdisplays
    wlogout

    kooha
    grim
  ];

  hardware.brillo.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
