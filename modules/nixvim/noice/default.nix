{
  lib,
  pkgs,
  config,
  ...
}:
{
  extraPlugins = with pkgs.vimPlugins; [ nui-nvim ];

  plugins.noice = {
    enable = true;

    settings = {
      presets = {
        bottom_search = true;
        command_palette = true;
        inc_rename = true;
        lsp_doc_border = true;
        long_message_to_split = true;
      };

      views = {
        cmdline_popup.border.style = "single";
        confirm.border = {
          style = "single";
          text.top = "";
        };
      };

      messages = {
        view = "mini";
        viewError = "mini";
        viewWarn = "mini";
      };

      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };

        progress.enabled = true;
        signature.enabled = !config.plugins.lsp-signature.enable;
      };

      popupmenu.backend = "nui";

      cmdline.format = {
        cmdline = {
          pattern = "^:";
          icon = "";
          lang = "vim";
          opts = {
            border = {
              text = {
                top = "Cmd";
              };
            };
          };
        };
        search_down = {
          kind = "search";
          pattern = "^/";
          icon = " ";
          lang = "regex";
        };
        search_up = {
          kind = "search";
          pattern = "^%?";
          icon = " ";
          lang = "regex";
        };
        filter = {
          pattern = "^:%s*!";
          icon = "";
          lang = "bash";
          opts = {
            border.text.top = "Bash";
          };
        };
        lua = {
          pattern = "^:%s*lua%s+";
          icon = "";
          lang = "lua";
        };
        help = {
          pattern = "^:%s*he?l?p?%s+";
          icon = "󰋖";
        };
        open = {
          pattern = "^:%s*e%s+";
          icon = "";
        };
        input = { };
      };

      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              { find = "%d+L, %d+B"; }
              { find = "; after #%d+"; }
              { find = "; before #%d+"; }
              { find = "%d fewer lines"; }
              { find = "%d more lines"; }
            ];
          };
          opts.skip = true;
        }
        {
          filter = {
            event = "msg_show";
            any = [
              { find = "Vim:E220"; }
              { find = "Error detected while processing TextChangedI Autocommands"; }
            ];
          };
          opts.skip = true;
        }
        {
          filter = {
            event = "msg_show";
            kind = "emsg";
            any = [
              { find = "E486:"; }
              { find = "e944"; }
            ];
          };
          opts.skip = true;
        }
        {
          filter = {
            event = "notify";
            any = [
              { find = "LSP client log is large"; }
              { find = " was properly created"; }
              { find = " was properly removed"; }
            ];
          };
          opts.skip = true;
        }
        {
          filter = {
            event = "notify";
            kind = "error";
            any = [ { find = "AST is null on this unit"; } ];
          };
          opts.skip = true;
        }
        {
          filter = {
            event = "notify";
            kind = "warn";
            any = [ { find = "No results for "; } ];
          };
          opts.skip = true;
        }
        {
          view = "cmdline_popup";
          filter = {
            event = "msg_show";
            kind = "echo";
            blocking = true;
            find = "Hop pattern";
          };
          opts.skip = true;
        }
        {
          view = "split";
          filter = {
            event = "msg_show";
            min_height = 20;
          };
        }
        {
          view = "split";
          filter = {
            event = "noice";
            kind = "debug";
          };
        }
      ];
    };
  };

  keymaps = lib.mkIf (config.plugins.telescope.enable && config.plugins.noice.enable) [
    {
      mode = "n";
      key = "<leader>fn";
      action = "<cmd>Telescope noice<CR>";
      options.desc = "Find notifications";
    }
  ];
}
