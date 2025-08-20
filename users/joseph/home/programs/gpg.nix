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
