{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    anki
    crosswords
    gnome-sudoku
    inkscape
    mixxx
    nemo
  ];
}
