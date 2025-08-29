{ ... }:
{
  fileSystems."/mnt/media" = {
    device = "nas.mad.internal:/media";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "nofail"
      "noatime"
    ];
  };
}
