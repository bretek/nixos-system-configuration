{ ... }:
let
  sources = import ../npins;
in
{
  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings.trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
