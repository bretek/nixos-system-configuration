{ ... }:
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock --grace 0 --no-fade-in";
      };

      listener = [
        {
          timeout = 30;
          on-timeout = "pidof hyprlock && hyprctl dispatch dpms off";
          on-resume = "pidof hyprlock && hyprctl dispatch dpms on";
        }
        {
          timeout = 300;
          on-timeout = "pidof hyprlock || hyprlock --grace 5";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        #{
        #  timeout = 1800;
        #  on-timeout = "systemctl suspend";
        #}
      ];
    };
  };
}
