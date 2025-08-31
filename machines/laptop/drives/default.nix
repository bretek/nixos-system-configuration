{ ... }:
{
  boot.supportedFilesystems = [
    "nfs"
  ];

  imports = [
    ./media.nix
    ./nas.nix
  ];
}
