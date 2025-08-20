{...}:
{
    programs.direnv = {
    enable = true;
    config = {
      hide_env_diff = true;
    };
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
