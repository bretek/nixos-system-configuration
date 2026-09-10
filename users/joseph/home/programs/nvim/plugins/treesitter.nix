{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.ripgrep
    pkgs.tree-sitter
  ];
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      nixGrammars = true;
      nixvimInjections = true;
      grammarPackages = config.programs.nixvim.plugins.treesitter.package.allGrammars;
    };
  };
}
