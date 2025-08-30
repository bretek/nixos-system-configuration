{ ... }:
{
  services = {
    fail2ban.enable = true;
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
  };
}
