{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    zsh
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "history"
        "branch"
        "fzf"
      ];
    };
  };
}
