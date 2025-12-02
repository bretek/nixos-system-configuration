{ pkgs, ... }:
{
  home.packages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server
  ];

  programs.nixvim.plugins = {
    treesitter.grammarPackages = [
      pkgs.vimPlugins.nvim-treesitter.builtGrammars.dockerfile
    ];

    lsp.servers = {
      docker_compose_language_service.enable = true;
      dockerls.enable = true;
    };
  };
}
