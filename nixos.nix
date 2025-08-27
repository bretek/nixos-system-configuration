{ ... }:
{
  nix = {
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
}
