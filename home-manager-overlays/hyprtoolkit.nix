{
  config,
  pkgs,
  lib,
  ...
}:

let

  cfg = config.programs.hyprtoolkit;

in
{
  meta.maintainers = with lib.maintainers; [
    bretek
  ];

  options.programs.hyprtoolkit = {
    enable = lib.mkEnableOption "" // {
      description = ''
        Whether to enable Hyprtoolkit.
      '';
    };

    package = lib.mkPackageOption pkgs "hyprtoolkit" { nullable = true; };

    settings = lib.mkOption {
      type =
        with lib.types;
        let
          valueType =
            nullOr (oneOf [
              bool
              int
              float
              str
              path
              (attrsOf valueType)
              (listOf valueType)
            ])
            // {
              description = "Hyprtoolkit configuration value";
            };
        in
        valueType;
      default = { };
      example = lib.literalExpression ''
        {

        }
      '';
      description = ''
        Hyprtoolkit configuration written in Nix. Entries with the same key should
        be written as lists. Variables' and colors' names should be quoted. See
        <https://wiki.hypr.land/Hypr-Ecosystem/hyprtoolkit/> for more examples.
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra configuration lines to add to `~/.config/hypr/hyprtoolkit.conf`.
      '';
    };

    sourceFirst = lib.mkEnableOption "putting source entries at the top of the configuration" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

    xdg.configFile."hypr/hyprtoolkit.conf" =
      let
        shouldGenerate = cfg.extraConfig != "" || cfg.settings != { };
      in
      lib.mkIf shouldGenerate {
        text =
          lib.optionalString (cfg.settings != { }) (
            lib.hm.generators.toHyprconf {
              attrs = cfg.settings;
              importantPrefixes = lib.optional cfg.sourceFirst "source";
            }
          )
          + lib.optionalString (cfg.extraConfig != null) cfg.extraConfig;
      };
  };
}
