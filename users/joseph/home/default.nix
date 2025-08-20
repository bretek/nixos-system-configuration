{ config, ... }:
{
  home = {
    shell.enableZshIntegration = true;
    file = {
      "Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nas/home/joseph/Documents";
      "Pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nas/home/joseph/Pictures";
      "Public".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nas/home/joseph/Public";
    };
  };

  imports = [
    ./hyprland
    ./programs
    ./services
  ];
}
