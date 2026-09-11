{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];
  programs.nixvim = {
    plugins = {
      opencode = {
        enable = true;
      };
    };

    extraConfigLua = ''
      vim.keymap.set({ "n", "x" }, "<leader>aa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>as", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
    '';
  };
}
