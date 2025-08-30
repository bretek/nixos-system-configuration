{ ... }:
{
  imports = [
    ./hardware.nix
    ./nixos.nix
    ./secure-boot.nix
    ./services.nix
    ./steam-stream.nix
  ];
}
