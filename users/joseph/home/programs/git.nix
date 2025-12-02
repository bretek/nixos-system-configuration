{ config, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      format = "openpgp";
      key = "61121921C9F8117C";
      signByDefault = true;
    };
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        email = config.user-options.gitEmail;
        name = "bretek";
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
