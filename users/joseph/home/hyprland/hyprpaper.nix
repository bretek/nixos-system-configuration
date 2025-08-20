{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = false;
      preload = [ "${./wallpapers/black_sand.jpg}" ];
      wallpaper = [
        ",${./wallpapers/black_sand.jpg}"
      ];
    };
  };
}
