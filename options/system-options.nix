{ lib, ... }:
{
  options = {
    system-options = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
      };
      isLaptop = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      driveFormat = lib.mkOption {
        type = lib.types.str;
        default = "btrfs";
      };
    };
  };
}
