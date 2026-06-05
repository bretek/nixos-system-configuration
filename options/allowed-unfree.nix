{ lib, ... }:
{
  options.allowedUnfree = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  options.permittedInsecure = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };
}
