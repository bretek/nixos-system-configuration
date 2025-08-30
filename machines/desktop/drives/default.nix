{ ... }:
{
  boot.supportedFilesystems = [
    "nfs"
    "btrfs"
  ];

  imports = [
    ./media.nix
    ./nas.nix
    ./nvme.nix
    ./root.nix
  ];
}
