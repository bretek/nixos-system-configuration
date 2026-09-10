{ config, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.go
    ];

    lsp.servers.gopls.enable = true;
  };
}
