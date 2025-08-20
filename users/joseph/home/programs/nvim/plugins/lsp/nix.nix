{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter.grammarPackages =
    with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
    ];
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.nixd
    pkgs.nix-doc
  ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          settings.formatting.command = [
            "nixfmt"
          ];
        };
      };
    };
  };
}
