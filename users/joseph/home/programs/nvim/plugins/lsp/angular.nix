{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.angular-language-server
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.angular
    ];

    lsp.servers.angularls = {
      enable = true;
      rootMarkers = [
        "angular.json"
        "nx.json"
      ];
      extraOptions = {
        cmd.__raw = ''
          (function()
            local probe_dir = require('lspconfig.util').find_node_modules_ancestor(vim.fn.getcwd())
            probe_dir = probe_dir and (probe_dir .. '/node_modules') or '''
            return {
              "ngserver", "--stdio",
              "--logFile", "/tmp/ngserver.log",
              "--logVerbosity", "verbose",
              "--tsProbeLocations", probe_dir,
              "--ngProbeLocations", probe_dir,
              "--forceStrictTemplates",
            }
          end)()
        '';
        on_new_config.__raw = ''
          function(new_config, new_root_dir)
            local probe_dir = require('lspconfig.util').find_node_modules_ancestor(new_root_dir)
            probe_dir = probe_dir and (probe_dir .. '/node_modules') or '''
            new_config.cmd = {
              "ngserver", "--stdio",
              "--logFile", "/tmp/ngserver.log",
              "--logVerbosity", "verbose",
              "--tsProbeLocations", probe_dir,
              "--ngProbeLocations", probe_dir,
              "--forceStrictTemplates",
            }
          end
        '';
      };
    };
  };
}
