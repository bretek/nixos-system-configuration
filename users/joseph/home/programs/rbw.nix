{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rbw
  ];
  programs.rbw = {
    enable = true;
    settings = {
      email = config.user-options.bitwardenEmail;
      pinentry = pkgs.wayprompt;
    };
  };
}
