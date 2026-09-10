{ config, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.yaml
    ];

    lsp.servers.yamlls.enable = true;
  };
}
