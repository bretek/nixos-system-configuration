{ pkgs, config, ... }:
{
  home = {
    packages = [
      pkgs.wl-kbptr
    ];
    file.".config/wl-kbptr/config".text = ''
      [general]
      home_row_keys=
      modes=floating

      [mode_floating]
      source=detect
      label_color=#${config.colorScheme.palette.base07}
      label_select_color=#${config.colorScheme.palette.base04}
      unselectable_bg_color=#2222
      selectable_bg_color=#${config.colorScheme.palette.base00}
      selectable_border_color=#${config.colorScheme.palette.base01}
      label_font_family=mono
      label_symbols=abcdefghijklmnopqrstuvwxyz

      [mode_click]
      button=left
    '';
  };
}
