{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    gnome-sudoku
    crosswords
    kdePackages.dolphin
    inkscape
    mixxx
  ];
}
