{ ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./kitty.nix
    ./nvim
    ./tmux.nix
    ./zsh.nix
  ];

  programs.lazydocker.enable = true;
}
