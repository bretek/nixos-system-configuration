{ pkgs, ... }:
{
  home.packages = [
    pkgs.roslyn-ls
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c_sharp
    ];

    lsp.servers.roslyn_ls.enable = true;
  };
}
