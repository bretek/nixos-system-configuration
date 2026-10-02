{ ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./music
    ./nvim
    ./rbw.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs.lazydocker.enable = true;
}
