{ config, ... }:
{
  imports = [
    ./plugins
    ./keymappings.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    colorschemes.base16.enable = true;
    colorschemes.base16.colorscheme = {
      base00 = "#${config.colorScheme.palette.base00}";
      base01 = "#${config.colorScheme.palette.base01}";
      base02 = "#${config.colorScheme.palette.base02}";
      base03 = "#${config.colorScheme.palette.base03}";
      base04 = "#${config.colorScheme.palette.base04}";
      base05 = "#${config.colorScheme.palette.base05}";
      base06 = "#${config.colorScheme.palette.base06}";
      base07 = "#${config.colorScheme.palette.base07}";
      base08 = "#${config.colorScheme.palette.base08}";
      base09 = "#${config.colorScheme.palette.base09}";
      base0A = "#${config.colorScheme.palette.base0A}";
      base0B = "#${config.colorScheme.palette.base0B}";
      base0C = "#${config.colorScheme.palette.base0C}";
      base0D = "#${config.colorScheme.palette.base0D}";
      base0E = "#${config.colorScheme.palette.base0E}";
      base0F = "#${config.colorScheme.palette.base0F}";
    };

    opts = {
      updatetime = 50;

      relativenumber = true;
      number = true;
      scrolloff = 8;
      signcolumn = "yes";
      colorcolumn = "80";
      termguicolors = true;
      wrap = false;

      hlsearch = true;
      incsearch = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      undofile = true;

      foldlevel = 99;
    };
  };
}
