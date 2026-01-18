{ ... }:
{
  home.shell.enableZshIntegration = true;

  imports = [
    ./hyprland
    ./programs
    ./services
  ];
}
