{ pkgs, ... }:
{
  # MOUNTS
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/media" = {
    device = "//nas.mad.internal/media";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60s"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "username=USERNAME"
      "password=PASSWORD"
      "rw"
      #"user"
      "users"
      "exec"
      "soft"
      "dir_mode=0777"
      "file_mode=0777"
      "uid=1000"
      "gid=100"
      "nocase"
    ];
  };
}
