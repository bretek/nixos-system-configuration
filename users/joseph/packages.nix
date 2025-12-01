{ pkgs, ... }:
{
  users.users.joseph.packages = with pkgs; [
    docker-compose
    gnome-sudoku
    inkscape
    mixxx
  ];
}
