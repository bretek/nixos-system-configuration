{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general.hide_cursor = true;

      animations = {
        enabled = true;
        bezier = [
          "easeInOutCubic, 0.65, 0, 0.35, 1"
        ];
        animation = [
          "fadeIn, 1, 15, easeInOutCubic"
        ];
      };

      background = {
        path = "${./wallpapers/black_sand.jpg}";
        blur_size = 1;
        blur_passes = 2;
      };

      shape = [
        {
          size = "230, 40";
          color = "rgb(${config.colorScheme.palette.base01})";
          rounding = -1;
          border_size = 0;
          xray = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          text = " $USER";
          color = "rgb(${config.colorScheme.palette.base05})";
          font_size = 11;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        {
          text = "$TIME";
          color = "rgb(${config.colorScheme.palette.base05})";
          font_size = 80;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = {
        size = "230, 40";
        outline_thickness = 0;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;
        inner_color = "rgb(${config.colorScheme.palette.base01})";
        check_color = "rgb(${config.colorScheme.palette.base01})";
        font_color = "rgb(${config.colorScheme.palette.base05})";
        fade_on_empty = false;
        placeholder_text = "Enter password...";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        hide_input = false;
        position = "0, -50";
        halign = "center";
        valign = "center";
      };
    };
  };
}
