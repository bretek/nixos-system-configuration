{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter.grammarPackages =
    with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c_sharp
    ];
  home.packages = [
    pkgs.roslyn-ls
  ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        csharp_ls = {
          enable = true;
        };
      };
    };
  };
}
