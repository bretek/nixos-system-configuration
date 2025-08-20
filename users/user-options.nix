{ lib, ... }:
{
  options = {
    user-options = {
      email = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
}
