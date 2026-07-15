{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brillo
    cliphist
    dunst
    grimblast
    hypridle
    hyprlock
    hyprpaper
    hyprshutdown
    hyprtoolkit
    playerctl
    rofi
    swayimg
    waybar
    wayland-pipewire-idle-inhibit
    wayprompt
    wdisplays
    wl-clipboard
    wlogout
    xdg-user-dirs
  ];

  hardware.brillo.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
