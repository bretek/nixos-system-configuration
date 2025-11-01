{ config, ... }:
{
  programs.git = {
    enable = true;
    userEmail = config.user-options.gitEmail;
    userName = "bretek";
    signing = {
      format = "openpgp";
      key = "61121921C9F8117C";
      signByDefault = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.lazygit.enable = true;
  programs.git.lfs.enable = true;
  programs.git-worktree-switcher = {
    enable = true;
    enableZshIntegration = true;
  };
}
