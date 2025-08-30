{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    mutableKeys = false;
    publicKeys = [
      {
        source = ./keys/61121921C9F8117C-pub.asc.key;
      }
    ];
  };

  #home.file."${config.home.homeDirectory}/.gnupg/private-keys-v1.d/FD3801BB42B98C74.key".source =
  # ./keys/secret.asc.key;

  programs.wayprompt = {
    enable = true;
    settings = {
      general = {
        corner-radius = 0;
      };
      colours = {
        background = config.colorScheme.palette.base00;
        border = config.colorScheme.palette.base03;
        text = config.colorScheme.palette.base07;
        error-text = config.colorScheme.palette.base07;
        pin-background = config.colorScheme.palette.base00;
        pin-border = config.colorScheme.palette.base01;
        pin-square = config.colorScheme.palette.base03;
        ok-button = config.colorScheme.palette.base0B;
        ok-button-border = config.colorScheme.palette.base0B;
        ok-button-text = config.colorScheme.palette.base00;
        not-ok-button = config.colorScheme.palette.base0A;
        not-ok-button-border = config.colorScheme.palette.base0A;
        not-ok-button-text = config.colorScheme.palette.base00;
        cancel-button = config.colorScheme.palette.base08;
        cancel-button-border = config.colorScheme.palette.base08;
        cancel-button-text = config.colorScheme.palette.base00;
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.wayprompt;
      program = builtins.baseNameOf (lib.getExe pkgs.wayprompt);
    };
    # TODO abstract terminal integrations
    enableZshIntegration = true;
  };
}
