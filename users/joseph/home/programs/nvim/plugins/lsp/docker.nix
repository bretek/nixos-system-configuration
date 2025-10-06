{ pkgs, ... }:
{
  home.packages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
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
