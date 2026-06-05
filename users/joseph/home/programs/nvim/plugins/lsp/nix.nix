{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixfmt
    pkgs.nixd
    pkgs.nix-doc
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.nix
    ];

    lsp.servers.nixd.enable = true;
  };
}
