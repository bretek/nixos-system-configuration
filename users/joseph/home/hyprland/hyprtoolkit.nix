{ config, ... }:
{
  programs.hyprtoolkit = {
    enable = true;

    settings = {
      background = "0xFF${config.colorScheme.palette.base00}";
      base = "0xFF${config.colorScheme.palette.base00}";
      alternate_base = "0xFF${config.colorScheme.palette.base05}";
      accent = "0xFF${config.colorScheme.palette.base03}";
      accent_secondary = "0xFF${config.colorScheme.palette.base01}";
      rounding_large = 15;
      rounding_small = 5;
    };
  };
}
