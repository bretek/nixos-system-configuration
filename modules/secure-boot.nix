{ pkgs, lib, ... }:
let
  sources = import ../nix/sources.nix;
  lanzaboote = import sources.lanzaboote { inherit pkgs; };
in
{
  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
