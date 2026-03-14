{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    crosswords
    gnome-sudoku
    inkscape
    mixxx
    nemo
  ];
}
