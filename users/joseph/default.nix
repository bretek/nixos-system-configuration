{
  pkgs,
  lib,
  ...
}:
let
  sources = import ../../npins;
  nixvim = import sources.nixvim;
  nix-colors = import sources.nix-colors { };
in
{
  imports = [ ./packages.nix ];
  users.users.joseph = {
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    isNormalUser = true;
    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [ ../../keys/id_ed25519_joseph.pub ];
  };
  programs.zsh.enable = true;

  home-manager.users.joseph = {
    imports = [
      (sources.agenix + "/modules/age-home.nix")
      ../../home-manager-overlays
      ../user-options.nix
      ./home
      nix-colors.homeManagerModules.default
      nixvim.homeModules.nixvim
    ]
    ++ lib.optional (builtins.pathExists ../../secrets/joseph/user-options.nix) ../../secrets/joseph/user-options.nix;

    age.secrets.secret1.file = ../../secrets/secret1.age;

    colorScheme = nix-colors.colorSchemes.material-darker;
    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
        ];
        config.common.default = "*";
      };
    };
  };
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
