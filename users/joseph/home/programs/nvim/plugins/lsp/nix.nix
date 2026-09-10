{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    nixfmt
    nixd
    nix-doc
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.nix
    ];

    lsp.servers.nixd = {
      enable = true;
      settings = {
        options = {
          home-manager = {
            expr = ''
              let
                sources = import ${../../../../../../../npins};
              in
              (import (sources.nixpkgs + "/nixos") {
                configuration = ${../../../../../../..}/configuration.nix;
              }).options.home-manager.users.type.getSubOptions []
            '';
          };
        };
      };
    };
  };
}
