{ pkgs, ... }:
{
  home.packages = [
    pkgs.angular-language-server
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      angular
    ];

    lsp.servers.angularls.enable = true;
  };
}
