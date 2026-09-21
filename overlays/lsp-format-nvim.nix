{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins.extend (
        finalPlugins: prevPlugins: {
          lsp-format-nvim = prevPlugins.lsp-format-nvim.overrideAttrs (old: {
            version = "2.7.3";
            src = prev.fetchFromGitHub {
              owner = "lukas-reineke";
              repo = "lsp-format.nvim";
              tag = "v2.7.3";
              hash = "sha256-D6N3dQq4WHticdHjrPr3edx775JV3H9/GlFVTR7dqoY=";
            };
          });
        }
      );
    })
  ];
}
