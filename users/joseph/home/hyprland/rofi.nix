{
  pkgs,
  config,
  ...
}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  color00 = mkLiteral "#${config.colorScheme.palette.base00}";
  color01 = mkLiteral "#${config.colorScheme.palette.base01}";
  color04 = mkLiteral "#${config.colorScheme.palette.base04}";
  color07 = mkLiteral "#${config.colorScheme.palette.base07}";
  color08 = mkLiteral "#${config.colorScheme.palette.base08}";
  color0D = mkLiteral "#${config.colorScheme.palette.base0D}";
in
{
  home.packages = with pkgs; [
    rofi-rbw-wayland
    rofi-bluetooth
    # TODO package wayland version
    #rofi-screenshot
    rofi-pulse-select
    rofi-network-manager
  ];
  programs.rofi = {
    enable = true;

    plugins = with pkgs; [
      rofi-emoji
    ];

    modes = [
      "drun"
      "emoji"
    ];

    extraConfig = {
      display-drun = " apps";
      display-run = " term";
      display-filebrowser = " files";
      display-window = " window";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };

    theme = {
      "*" = {
        red = color08;
        selected-active-foreground = mkLiteral "var(background)";
        lightfg = color04;
        separatorcolor = mkLiteral "var(foreground)";
        urgent-foreground = mkLiteral "var(red)";
        alternate-urgent-background = mkLiteral "var(lightbg)";
        lightbg = color01;
        background-color = mkLiteral "transparent";
        border-color = mkLiteral "var(foreground)";
        normal-background = mkLiteral "var(background)";
        selected-urgent-background = mkLiteral "var(red)";
        alternate-active-background = mkLiteral "var(lightbg)";
        spacing = 2;
        blue = color0D;
        alternate-normal-foreground = mkLiteral "var(foreground)";
        urgent-background = mkLiteral "var(background)";
        selected-normal-foreground = mkLiteral "var(lightbg)";
        active-foreground = mkLiteral "var(blue)";
        background = color00;
        selected-active-background = mkLiteral "var(blue)";
        active-background = mkLiteral "var(background)";
        selected-normal-background = mkLiteral "var(lightfg)";
        alternate-normal-background = mkLiteral "var(lightbg)";
        foreground = color07;
        selected-urgent-foreground = mkLiteral "var(background)";
        normal-foreground = mkLiteral "var(foreground)";
        alternate-urgent-foreground = mkLiteral "var(red)";
        alternate-active-foreground = mkLiteral "var(blue)";
      };

      "element" = {
        padding = mkLiteral "1px";
        cursor = mkLiteral "pointer";
        spacing = mkLiteral "5px";
        border = 0;
      };
      "element normal.normal" = {
        background-color = mkLiteral "var(normal-background)";
        text-color = mkLiteral "var(normal-foreground)";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "var(urgent-background)";
        text-color = mkLiteral "var(urgent-foreground)";
      };
      "element normal.active" = {
        background-color = mkLiteral "var(active-background)";
        text-color = mkLiteral "var(active-foreground)";
      };
      "element selected.normal" = {
        background-color = mkLiteral "var(selected-normal-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "var(selected-urgent-background)";
        text-color = mkLiteral "var(selected-urgent-foreground)";
      };
      "element selected.active" = {
        background-color = mkLiteral "var(selected-active-background)";
        text-color = mkLiteral "var(selected-active-foreground)";
      };
      "element alternate.normal" = {
        background-color = mkLiteral "var(alternate-normal-background)";
        text-color = mkLiteral "var(alternate-normal-foreground)";
      };
      "element alternate.urgent" = {
        background-color = mkLiteral "var(alternate-urgent-background)";
        text-color = mkLiteral "var(alternate-urgent-foreground)";
      };
      "element alternate.active" = {
        background-color = mkLiteral "var(alternate-active-background)";
        text-color = mkLiteral "var(alternate-active-foreground)";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        cursor = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        size = mkLiteral "1.0000em";
        cursor = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "window" = {
        padding = 5;
        background-color = mkLiteral "var(background)";
        border = 1;
      };
      "mainbox" = {
        padding = 0;
        border = 0;
      };
      "message" = {
        padding = mkLiteral "1px";
        border-color = mkLiteral "var(separatorcolor)";
        border = mkLiteral "2px dash 0px 0px";
      };
      "textbox" = {
        text-color = mkLiteral "var(foreground)";
      };
      "listview" = {
        padding = mkLiteral "2px 0px 0px";
        scrollbar = true;
        border-color = mkLiteral "var(separatorcolor)";
        spacing = mkLiteral "2px";
        fixed-height = 0;
        border = mkLiteral "2px dash 0px 0px";
      };
      "scrollbar" = {
        width = mkLiteral "4px";
        padding = 0;
        handle-width = mkLiteral "8px";
        border = 0;
        handle-color = mkLiteral "var(normal-foreground)";
      };
      "sidebar" = {
        border-color = mkLiteral "var(separatorcolor)";
        border = mkLiteral "2px dash 0px 0px";
      };
      "button" = {
        cursor = mkLiteral "pointer";
        spacing = 0;
        text-color = mkLiteral "var(normal-foreground)";
      };
      "button selected" = {
        background-color = mkLiteral "var(selected-normal-background)";
        text-color = mkLiteral "var(selected-normal-foreground)";
      };
      "num-filtered-rows" = {
        expand = false;
        text-color = mkLiteral "Gray";
      };
      "num-rows" = {
        expand = false;
        text-color = mkLiteral "Gray";
      };
      "textbox-num-sep" = {
        expand = false;
        str = "/";
        text-color = mkLiteral "Gray";
      };
      "inputbar" = {
        padding = mkLiteral "1px";
        spacing = mkLiteral "0px";
        text-color = mkLiteral "var(normal-foreground)";
        children = [
          "prompt"
          "textbox-prompt-colon"
          "entry"
          "overlay"
          "num-filtered-rows"
          "textbox-num-sep"
          "num-rows"
          "case-indicator"
        ];
      };
      "overlay" = {
        padding = mkLiteral "0px 0.2000em";
        background-color = mkLiteral "var(normal-foreground)";
        foreground-color = mkLiteral "var(normal-background)";
        margin = mkLiteral "0px 0.2000em";
        text-color = mkLiteral "var(normal-background)";
      };
      "case-indicator" = {
        spacing = 0;
        text-color = mkLiteral "var(normal-foreground)";
      };
      "entry" = {
        text-color = mkLiteral "var(normal-foreground)";
        cursor = mkLiteral "text";
        spacing = 0;
        placeholder-color = mkLiteral "Gray";
        placeholder = "Type to filter";
      };
      "prompt" = {
        spacing = 0;
        text-color = mkLiteral "var(normal-foreground)";
      };
      "textbox-prompt-colon" = {
        margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
        expand = false;
        str = ":";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
