{ pkgs, ... }:
{
  hardware = {
    bluetooth.enable = true;
    steam-hardware.enable = true;
    xone.enable = true;
    usb-modeswitch.enable = true;

    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
      enable = true;
      enable32Bit = true;
    };
  };
}
