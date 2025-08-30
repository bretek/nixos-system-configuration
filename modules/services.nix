{ ... }:
{
  services = {
    pipewire.enable = true;
    printing.enable = true;
    fstrim.enable = true;
    fail2ban.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
