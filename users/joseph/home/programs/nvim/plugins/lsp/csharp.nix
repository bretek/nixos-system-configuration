{ config, ... }:
{
  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.c_sharp
    ];

    lsp.servers.csharp_ls.enable = true;
  };
}
