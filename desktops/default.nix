{ ... }:
{
  imports = [
    ./kde.nix
    ./hyprland.nix
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
