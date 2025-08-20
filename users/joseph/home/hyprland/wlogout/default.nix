{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ jq ];
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "${lib.getExe pkgs.hyprlock}";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "shutdown now";
        keybind = "x";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        keybind = "o";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        keybind = "s";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        keybind = "h";
      }
    ];

    style = builtins.concatStringsSep "\n" [
      ''
        @define-color background #${config.colorScheme.palette.base01};
        @define-color highlight #${config.colorScheme.palette.base02};

        #lock {
            background-image: image(url("${./icons/lock.png}"));
        }
        #reboot {
            background-image: image(url("${./icons/reboot.png}"));
        }
        #logout {
            background-image: image(url("${./icons/logout.png}"));
        }
        #shutdown {
            background-image: image(url("${./icons/shutdown.png}"));
        }
        #suspend {
            background-image: image(url("${./icons/suspend.png}"));
        }
        #hibernate {
            background-image: image(url("${./icons/hibernate.png}"));
        }

        @import "${./style.css}";
      ''
    ];
  };
}
