{ ... }:
{
      imports = [
          ./lsp
          ./treesitter.nix
          ./telescope.nix
          ./ts-autotag.nix
      ];

    programs.nixvim.plugins = {
      web-devicons.enable = true;
    };
}
