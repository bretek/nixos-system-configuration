{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    android-file-transfer
    anki
    crosswords
    gnome-sudoku
    inkscape
    mixxx
    nemo
    rquickshare
  ];
}
