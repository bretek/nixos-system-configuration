{...}:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      bind c new-window -c "#{pane_current_path}"
      set -g status-style "bg=brightblack"
    '';
  };
}
