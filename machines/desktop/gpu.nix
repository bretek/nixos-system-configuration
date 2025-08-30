{ pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
