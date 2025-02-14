{
  lib,
  config,
  helpers,
  ...
}:
let
  cfg = config.plugins.bufferline;
in
{
  plugins.bufferline =
    let
      mouse = {
        right = "'vertical sbuffer %d'";
        close = ''
          function(bufnum)
            require("mini.bufremove").delete(bufnum)
          end
        '';
      };
    in
    {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      settings = {
        options = {
          always_show_bufferline = false;
          close_command.__raw = mouse.close;
          diagnostics = "nvim_lsp";
          right_mouse_command.__raw = mouse.right;
          separator_style = "thick";
          sort_by = "extension";

          diagnostics_indicator = ''
            function(count, level, diagnostics_dict, context)
              local s = ""
              for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                  or (e == "warning" and " " or " " )
                if(sym ~= "") then
                  s = s .. n .. sym
                end
              end
              return s
            end
          '';

          groups.items = [
            {
              name = "Tests";
              highlight = {
                underline = true;
                fg = "#a6da95";
                sp = "#494d64";
              };
              priority = 2;
              matcher.__raw = ''
                function(buf)
                  return buf.name:match('%test') or buf.name:match('%.spec')
                end
              '';
            }
            {
              name = "Docs";
              highlight = {
                undercurl = true;
                fg = "#ffffff";
                sp = "#494d64";
              };
              auto_close = false;
              matcher.__raw = ''
                function(buf)
                  return buf.name:match('%.md') or buf.name:match('%.txt')
                end
              '';
            }
          ];

          offsets = [
            {
              filetype = "neo-tree";
              text = "File Tree";
              text_align = "center";
              highlight = "Directory";
              separator = true;
            }
          ];
        };

        highlights =
          with lib.plusultra.theme.catppuccin-mocha;
          let
            selectedAttrsSet = builtins.listToAttrs (
              map
                (name: {
                  inherit name;
                  value.bg = color1;
                })
                [
                  "buffer_selected"
                  "tab_selected"
                  "numbers_selected"
                  "close_button_selected"
                  "duplicate_selected"
                  "modified_selected"
                  "info_selected"
                  "warning_selected"
                  "error_selected"
                  "hint_selected"
                  "diagnostic_selected"
                  "info_diagnostic_selected"
                  "warning_diagnostic_selected"
                  "error_diagnostic_selected"
                  "hint_diagnostic_selected"
                ]
            );

            highlights = {
              styles = [ "bold" ];
              custom.all = selectedAttrsSet // {
                fill.bg = color0;
                separator.fg = color0;
                separator_visible.fg = color0;
                separator_selected = {
                  bg = color1;
                  fg = color0;
                };
              };
            };
          in
          helpers.mkRaw "require('catppuccin.groups.integrations.bufferline').get(${helpers.toLuaObject highlights})";
      };
    };

  keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>bP";
      action = "<cmd>BufferLineTogglePin<cr>";
      options.desc = "Pin buffer toggle";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferLinePick<cr>";
      options.desc = "Pick Buffer";
    }
    {
      mode = "n";
      key = "<leader>bsd";
      action = "<cmd>BufferLineSortByDirectory<cr>";
      options.desc = "Sort By Directory";
    }
    {
      mode = "n";
      key = "<leader>bse";
      action = "<cmd>BufferLineSortByExtension<cr>";
      options.desc = "Sort By Extension";
    }
    {
      mode = "n";
      key = "<leader>bsr";
      action = "<cmd>BufferLineSortByRelativeDirectory<cr>";
      options.desc = "Sort By Relative Directory";
    }
  ];
}
