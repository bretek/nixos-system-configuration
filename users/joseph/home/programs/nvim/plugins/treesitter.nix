{ pkgs, config, ... }:
{
  home.packages = [ pkgs.ripgrep ];
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      nixGrammars = false;
      nixvimInjections = true;
      grammarPackages = config.programs.nixvim.plugins.treesitter.package.allGrammars;
    };
  };
}
