{ config, lib, ... }:
{
  options = {
    user-options = {
      email = lib.mkOption {
        type = lib.types.str;
      };
      gitEmail = lib.mkOption {
        type = lib.types.str;
        default = config.user-options.email;
      };
      bitwardenEmail = lib.mkOption {
        type = lib.types.str;
        default = config.user-options.email;
      };
    };
  };
}
