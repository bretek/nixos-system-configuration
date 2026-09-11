{ ... }:
{
  imports = [
    ./lsp
    ./opencode.nix
    ./snack.nix
    ./telescope.nix
    ./treesitter.nix
    ./ts-autotag.nix
  ];

  programs.nixvim.plugins = {
    web-devicons.enable = true;
  };
}
