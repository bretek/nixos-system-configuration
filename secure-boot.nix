{ pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
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
    pkiBundle = "/var/lib/sbctl";
  };
}
