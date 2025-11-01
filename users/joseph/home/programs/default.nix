{ ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./nvim
    ./rbw.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs.lazydocker.enable = true;
}
