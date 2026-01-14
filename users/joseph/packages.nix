{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    gnome-sudoku
    crosswords
    inkscape
    mixxx
  ];
}
