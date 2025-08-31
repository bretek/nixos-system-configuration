{ pkgs, lib, ... }:
{
  imports = [
    ./dunst.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./rofi.nix
    ./waybar
    ./wl-kbptr.nix
    ./wlogout
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.kdePackages.breeze;
    };
  };
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    theme.package = pkgs.kdePackages.breeze;
    iconTheme = {
      name = "breeze";
      package = pkgs.kdePackages.breeze-icons;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Breeze-Dark";
        color-scheme = "prefer-dark";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";

      monitor = [
        "DP-1, 3840x1600@144, 0x0, 1"
      ];

      input = {
        kb_layout = "us";
        repeat_delay = "250";
        repeat_rate = "30";

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = false;
          middle_button_emulation = false;
          tap-to-click = true;
          drag_lock = false;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = true;
      };

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      workspace = [
        "w[t1], gapsout:0"
        "w[t1], border:0"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vrr = 1;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        initial_workspace_tracking = 0;
        middle_click_paste = false;
        enable_anr_dialog = true; # Application not Responding (ANR)
        anr_missed_pings = 15; # ANR Threshold default 1 is too low
      };

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      render = {
        direct_scanout = 0;
      };

      cursor = {
        no_hardware_cursors = 2; # change to 1 if want to disable
        enable_hyprcursor = true;
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      exec-once = [
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.waybar}"
        "${lib.getExe pkgs.dunst}"
        "${lib.getExe pkgs.wayland-pipewire-idle-inhibit}"
      ];

      bind = [
        # Session
        "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
        "$mainMod ALT, Q, killactive"
        "$mainMod, L, exec, loginctl lock-session"
        "$mainMod, Backspace, exec, ${./scripts/Wlogout.sh}"

        # Programs
        # TODO add scripts
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod ALT, E, exec, rofi -show emoji"
        "$mainMod ALT, N, exec, rofi-network-manager"
        # TODO fix vpn config permissions
        "$mainMod ALT, V, exec, rofi-vpn"
        "$mainMod ALT, B, exec, rofi-bluetooth"
        "$mainMod ALT, P, exec, rofi-rbw"
        "$mainMod ALT, M, exec, ${./scripts/RofiBeats.sh}"
        "$mainMod, S, exec, ${./scripts/RofiSearch.sh}"
        "$mainMod ALT, H, exec, ${./scripts/RofiKeyBinds.sh}"
        "$mainMod, V, exec, ${./scripts/ClipManager.sh}"
        "$mainMod, M, exec, wl-kbptr"
        #TODO screenshot
        #"$mainMod ALT, S, exec, rofi-screenshot"

        # Windowing
        "$mainMod, SPACE, togglefloating"
        "$mainMod ALT, F, fullscreen"
        "ALT, tab, cyclenext"
        "ALT, tab, bringactivetotop"

        "$mainMod SHIFT, I, togglesplit"
        "$mainMod SHIFT, T, pseudo"

        # Navigation
        "$mainMod, LEFT, movefocus, l"
        "$mainMod, RIGHT, movefocus, r"
        "$mainMod, UP, movefocus, u"
        "$mainMod, DOWN, movefocus, d"

        "$mainMod CTRL, LEFT, movewindow, l"
        "$mainMod CTRL, RIGHT, movewindow, r"
        "$mainMod CTRL, UP, movewindow, u"
        "$mainMod CTRL, DOWN, movewindow, d"

        "$mainMod ALT, LEFT, swapwindow, l"
        "$mainMod ALT, RIGHT, swapwindow, r"
        "$mainMod ALT, UP, swapwindow, u"
        "$mainMod ALT, DOWN, swapwindow, d"

        "$mainMod, Q, workspace, 1"
        "$mainMod, W, workspace, 2"
        "$mainMod, F, workspace, 3"
        "$mainMod, P, workspace, 4"
        "$mainMod, G, workspace, 5"

        "$mainMod SHIFT, Q, movetoworkspace, 1"
        "$mainMod SHIFT, W, movetoworkspace, 2"
        "$mainMod SHIFT, F, movetoworkspace, 3"
        "$mainMod SHIFT, P, movetoworkspace, 4"
        "$mainMod SHIFT, G, movetoworkspace, 5"

        # Media keys
        #-----------
        #TODO
      ];
      binde = [
        "$mainMod SHIFT, LEFT, resizeactive,-50 0"
        "$mainMod SHIFT, RIGHT, resizeactive,50 0"
        "$mainMod SHIFT, UP, resizeactive,0 -50"
        "$mainMod SHIFT, DOWN, resizeactive,0 50"
      ];

      windowrulev2 = [
        #TODO
        "idleinhibit fullscreen, fullscreen:1"
      ];

      env = [
        # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
        # Environment variables. See https://wiki.hyprland.org/Configuring/Environment-variables/

        # Set your defaults editor through ENV in ~/.config/hypr/UserConfigs/01-UserDefaults.conf

        # environment-variables
        # Toolkit Backend Variables
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "CLUTTER_BACKEND,wayland"

        #Run SDL2 applications on Wayland.
        #Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
        "SDL_VIDEODRIVER,wayland"

        # xdg Specifications
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"

        # QT Variables
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORMTHEME,qt6ct"

        # hyprland-qt-support
        "QT_QUICK_CONTROLS_STYLE,org.hyprland.style"

        # xwayland apps scale fix (useful if you are use monitor scaling).
        # Set same value if you use scaling in Monitors.conf
        # 1 is 100% 1.5 is 150%
        # see https://wiki.hyprland.org/Configuring/XWayland/
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"

        # Bibata-Modern-Ice-Cursor
        # NOTE! You must have the hyprcursor version to activate this.
        # https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor/
        #"HYPRCURSOR_THEME,Bibata-Modern-Ice
        #"HYPRCURSOR_SIZE,24

        # firefox
        "MOZ_ENABLE_WAYLAND,1"

        # electron >28 apps (may help) ##
        # https://www.electronjs.org/docs/latest/api/environment-variables
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
    };
  };
}
