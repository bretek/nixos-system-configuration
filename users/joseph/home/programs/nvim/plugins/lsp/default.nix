{ pkgs, ... }:
{
  imports = [
    ./angular.nix
    ./csharp.nix
    ./docker.nix
    ./go.nix
    ./html.nix
    ./nix.nix
    ./terraform.nix
    ./typescript.nix
    ./yaml.nix
  ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          K = "hover";
          gr = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          ga = "code_action";
          gc = "rename";
          gs = "signature_help";
        };
      };
    };

    lsp-format = {
      enable = true;
      package = pkgs.vimPlugins.lsp-format-nvim;
    };

    luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
          paths = [
            "${pkgs.vimPlugins.friendly-snippets}"
            "${pkgs.vscode-extensions.angular.ng-template}"
          ];
        }
      ];
    };

    nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [
          "TelescopePrompt"
          "vim"
        ];
      };
    };

    lsp-signature = {
      enable = true;
      settings = {
        hint_prefix = " ";
      };
    };

    cmp = {
      enable = true;

      settings = {
        autoEnableSources = true;
        experimental = {
          ghost_text = true;
        };

        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };

        snippet = {
          expand = "luasnip";
        };

        sources = [
          { name = "nvim_lsp"; }
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          {
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
        ];

        window = {
          completion = {
            border = "single";
          };
          documentation = {
            border = "single";
          };
        };

        mapping = {
          "<Down>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<CR>" = ''
            cmp.mapping({
              i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                  fallback()
                end
              end,
              s = cmp.mapping.confirm({ select = true }),
              c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            })
          '';
        };
      };
    };

    cmp-nvim-lsp = {
      enable = true;
    }; # lsp
    cmp-buffer = {
      enable = true;
    };
    cmp-path = {
      enable = true;
    }; # file system paths
    cmp_luasnip = {
      enable = true;
    }; # snippets
    cmp-cmdline = {
      enable = false;
    }; # autocomplete for cmdline

    dap = {
      enable = true;
    };
  };
}
