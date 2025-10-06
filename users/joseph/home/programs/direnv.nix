{ ... }:
{
  programs.direnv = {
    enable = true;
    config = {
      hide_env_diff = true;
      load_dotenv = true;
    };
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
