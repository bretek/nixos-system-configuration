{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    terraform-ls
    tflint
    terraform-docs
    terraform-plugin-docs
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.terraform
    ];

    lsp.servers = {
      terraformls.enable = true;
      tflint.enable = true;
    };
  };
}
