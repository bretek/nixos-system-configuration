{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      html
    ];

    lsp.servers.html.enable = true;
  };
}
