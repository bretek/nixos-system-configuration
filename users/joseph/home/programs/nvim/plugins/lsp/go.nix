{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      go
    ];

    lsp.servers.gopls.enable = true;
  };
}
