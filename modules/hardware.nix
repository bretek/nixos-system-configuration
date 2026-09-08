{ pkgs, lib, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          FastConnectable = true;
        };
      };
    };
    steam-hardware.enable = true;
    xone.enable = true;
    usb-modeswitch.enable = true;

    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        vpl-gpu-rt
        intel-compute-runtime
      ];
      enable = true;
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
    # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
  };

  # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
  #hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [
    "i915.force_probe=56a6"
    "xe.force_probe=!56a6"
  ];
  services.fwupd.enable = true;
}
