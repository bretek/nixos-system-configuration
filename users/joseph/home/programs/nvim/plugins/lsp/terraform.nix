{ pkgs, ... }:
{
  home.packages = with pkgs; [
    terraform-ls
    tflint
    terraform-docs
    terraform-plugin-docs
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.terraform
    ];

    lsp.servers = {
      terraformls.enable = true;
      tflint.enable = true;
    };
  };
}
