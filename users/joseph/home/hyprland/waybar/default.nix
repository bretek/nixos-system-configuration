{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.waybar = {
    enable = true;

    style = builtins.concatStringsSep "\n" [
      ''
        @define-color background alpha(#${config.colorScheme.palette.base01}, 0.85);
        @define-color focusedButton alpha(#${config.colorScheme.palette.base02}, 0.85);
        @define-color warningOrange #${config.colorScheme.palette.base0A};
        @define-color warningRed #${config.colorScheme.palette.base0F};

        @import "${./style.css}";
      ''
    ];

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "custom/appmenu"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "custom/power"
        ];

        "custom/appmenu" = {
          format = "";
          tooltip = false;
          on-click = "rofi -show drun";
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "${../scripts/Wlogout.sh}";
        };

        pulseaudio = {
          format = "{icon}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          format-muted = "󰝟";
          max-volume = 100;
          on-click = "${lib.getExe pkgs.pavucontrol}";
        };

        bluetooth = {
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "󰂯 ({num_connections})";
          tooltip-format = "{controller_alias}\t{controller_address}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "${lib.getExe' pkgs.blueman "blueman-manager"}";
        };

        network = {
          format-wifi = " {icon}";
          format-ethernet = "󰌙";
          format-disconnected = "";
          tooltip-format = "{ipaddr} {bandwidthUpBits} {bandwidthDownBits}";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-disconnected = " Disconnected";
          interval = 1;
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤢"
            "󰤨"
          ];
        };

        battery = {
          design-capacity = true;
          format = "{icon}";
          format-icons = {
            default = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            charging = [
              "󰢟"
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
          };
          states = {
            warning = 30;
            critical = 15;
          };
        };

        clock = {
          format = "{:%F %R}";
          tooltip-format = "<span>{calendar}</span>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#${config.colorScheme.palette.base07}'><b>{}</b></span>";
              days = "<span color='#${config.colorScheme.palette.base07}'><b>{}</b></span>";
              weekdays = "<span color='#${config.colorScheme.palette.base07}'><b>{}</b></span>";
              today = "<span color='#${config.colorScheme.palette.base04}'><b>{}</b></span>";
            };
          };
        };
      };
    };
  };
}
