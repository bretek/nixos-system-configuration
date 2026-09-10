{ config, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.html
    ];

    lsp.servers.html.enable = true;
  };
}
