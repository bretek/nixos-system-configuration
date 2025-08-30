{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      xow_dongle-firmware = prev.xow_dongle-firmware.overrideAttrs (old: {
        installPhase = ''
          install -Dm644 xow_dongle.bin $out/lib/firmware/xow_dongle.bin
          ln $out/lib/firmware/xow_dongle.bin $out/lib/firmware/xow_dongle_045e_02fe.bin
          install -Dm644 xow_dongle_045e_02e6.bin $out/lib/firmware/xow_dongle_045e_02e6.bin
        '';
      });
    })
  ];
}
