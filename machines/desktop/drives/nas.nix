{ ... }:
{
  fileSystems."/mnt/nas" = {
    device = "nas.mad.internal:/nas";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "noatime"
    ];
  };
}
