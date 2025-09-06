{ ... }:
{
  services = {
    fail2ban.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    pipewire.enable = true;
    printing.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
    thermald.enable = true;
    xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };
  };
}
