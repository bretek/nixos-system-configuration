{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "joseph";
    dataDir = "/home/joseph";
    openDefaultPorts = true;
    settings = {
      devices = {
        "nas" = {
          id = "56WZ5CO-VLWH4SZ-KVF5K5U-36J2K76-MKV7BD5-3BCFABG-TGF4ABI-NEZ43QF";
        };
      };
      folders = {
        "JosephDocuments" = {
          path = "/home/joseph/Documents";
          devices = [
            "nas"
          ];
        };
      };
      options = {
        urAccepted = -1;
      };
    };
  };
}
