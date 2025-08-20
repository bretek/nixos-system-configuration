{pkgs, lib, ...}:
let
  steamos-session-select = pkgs.writeShellApplication {
    name = "steamos-session-select";
    text = ''
      #!/usr/bin/env sh
      steam -shutdown
    '';
  };
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

    environment.systemPackages = with pkgs; [
      steamos-session-select
      xorg.xvfb
    ];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        #"--rt"
        #"--adaptive-sync"
        #"--steam"
      ];
    };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
        #"--rt"
        #"--adaptive-sync"
        #"--steam"
    ];
    gamescopeSession.steamArgs = [
      #"-tenfoot"
      #"-pipewire-dmabuf"
      "-steamdeck"
      "-steamos3"
    ];
    localNetworkGameTransfers.openFirewall = true;
  };

    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
      applications = {
        env = {
          PATH = "$(PATH):$(HOME)/.local/bin";
        };
        apps = [
          {
            name = "Variable Desktop";
            prep-cmd = [
              {
                #do = "sh -c \"kscreen-dector output.DP-1.mode.1920x1080@60 ; kscreen-doctor output.DP-1.mode.\${SUNSHINE_CLIENT_WIDTH}x\${SUNSHINE_CLIENT_HEIGHT}@\${SUNSHINE_CLIENT_FPS}\"";
                do = "kscreen-doctor output.DP-1.mode.1920x1080@60";
                undo = "kscreen-doctor output.DP-1.mode.3840x1600@144";
              }
            ];
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
        ];
      };
    };
}
