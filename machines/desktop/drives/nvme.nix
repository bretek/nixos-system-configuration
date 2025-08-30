{ ... }:
{
  fileSystems."/mnt/NVME" = {
    device = "/dev/disk/by-uuid/ffb2fa16-885d-4ff2-9c8b-78d9682107cf";
    fsType = "btrfs";
    options = [
      "nofail"
    ];
  };
}
