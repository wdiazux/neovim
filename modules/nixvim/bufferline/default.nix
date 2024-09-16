{
  config,
  lib,
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
        right = # Lua
          "'vertical sbuffer %d'";
        close = # Lua
          ''
            function(bufnum)
              require("mini.bufremove").delete(bufnum)
            end
          '';
      };
    in
    {
      enable = true;

      settings = {
        options = {
          mode = "buffers";
          always_show_bufferline = false;
          buffer_close_icon = "󰅖";
          close_command.__raw = mouse.close;
          close_icon = "";
          diagnostics = "nvim_lsp";
          diagnostics_indicator = # Lua
            ''
              function(count, level, diagnostics_dict, context)
                local s = ""
                for e, n in pairs(diagnostics_dict) do
                  local sym = e == "error" and " "
                    or (e == "warning" and " " or "" )
                  if(sym ~= "") then
                    s = s .. " " .. n .. sym
                  end
                end
                return s
              end
            '';
          # Will make sure all names in bufferline are unique
          enforce_regular_tabs = false;

          groups = {
            options.toggle_hidden_on_enter = true;

            items = [
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
          };

          indicator = {
            style = "icon";
            icon = "▎";
          };

          left_trunc_marker = "";
          max_name_length = 18;
          max_prefix_length = 15;
          modified_icon = "●";

          persist_buffer_sort = true;
          right_mouse_command.__raw = mouse.right;
          right_trunc_marker = "";
          separator_style = "slant";
          show_buffer_close_icons = true;
          show_buffer_icons = true;
          show_close_icon = true;
          show_tab_indicators = true;
          sort_by = "extension";
          tab_size = 18;

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
                  value = {
                    bg = color1;
                  };
                })
                [
                  # "separator_selected" # Handled uniquely
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
      action = ":BufferLineTogglePin<cr>";
      options = {
        desc = "Pin buffer toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = ":BufferLinePick<cr>";
      options = {
        desc = "Pick Buffer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bsd";
      action = ":BufferLineSortByDirectory<cr>";
      options = {
        desc = "Sort By Directory";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bse";
      action = ":BufferLineSortByExtension<cr>";
      options = {
        desc = "Sort By Extension";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>bsr";
      action = ":BufferLineSortByRelativeDirectory<cr>";
      options = {
        desc = "Sort By Relative Directory";
        silent = true;
      };
    }
  ];
}
