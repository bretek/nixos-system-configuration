{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 5000;
        no_fade_in = false;
        disable_loading_bar = true;
      };
      background = {
        path = "${./wallpapers/black_sand.jpg}";
        blur_size = 3;
      };

      label = [
        {
          text = "cmd[update:0] echo \"   $USER\" | tr '[:lower:]' '[:upper:]'";
          color = "rgb(${config.colorScheme.palette.base05})";
          font_size = 10;
          position = "0, 0";
          halign = "left";
          valign = "top";
        }
        {
          text = "cmd[update:1000] echo $TIME";
          color = "rgb(${config.colorScheme.palette.base05})";
          font_size = 80;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%A %F')\" </b>\"";
          color = "rgb(${config.colorScheme.palette.base05})";
          font_size = 20;
          position = "-5, -5";
          halign = "right";
          valign = "top";
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
