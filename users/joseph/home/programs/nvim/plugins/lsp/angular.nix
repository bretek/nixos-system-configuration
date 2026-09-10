{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.angular-language-server
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.angular
    ];

    lsp.servers.angularls.enable = true;
  };
}
