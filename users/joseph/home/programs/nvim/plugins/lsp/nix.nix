{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixfmt
    pkgs.nixd
    pkgs.nix-doc
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.nix
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
