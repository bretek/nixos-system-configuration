{ pkgs, ... }:
let
  profilePath = "~/.nix-profile/";
  homePath = "/home/joseph";
  lv2Path = "${profilePath}/lib/lv2";
  vstPath = "${profilePath}/lib/vst:${homePath}/.vst:${homePath}/.vst/yabridge";
  vst3Path = "${profilePath}/lib/vst3";
  ladspaPath = "${profilePath}/lib/ladspa";
in
{
  systemd.user.sessionVariables = {
    LV2_PATH = lv2Path;
    VST_PATH = vstPath;
    LXVST_PATH = vstPath;
    VST3_PATH = vst3Path;
    LADSPA_PATH = ladspaPath;
  };

  home.packages = with pkgs; [
    calf
    distrho-ports
    dragonfly-reverb
    eq10q
    (pkgs.callPackage ./fabla.nix { })
    fil-plugins
    geonkick
    guitarix
    lsp-plugins
    #meters-lv2
    x42-gmsynth
    x42-plugins
  ];
}
