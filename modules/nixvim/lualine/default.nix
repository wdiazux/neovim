{
  lib,
  pkgs,
  ...
}:
with lib.plusultra;
with lib.plusultra.theme.catppuccin-mocha; {
  config = {
    extraPlugins = with pkgs.vimPlugins; [neodev-nvim];

    extraConfigLuaPre = ''
      require("neodev").setup {
        lspconfig = true,
        library = {
          enabled = true,
          plugins = true,
          runtime = true,
          types = true,
        },
      }
    '';

    opts.laststatus = 3;

    plugins.lualine = {
      enable = true;

      globalstatus = true;

      componentSeparators = {
        left = "⋮";
        right = "⋮";
      };

      sections = {
        lualine_a = [
          {
            name = lua.mkRaw ''
              function()
                return ""
              end
            '';
          }
        ];
        lualine_b = [
          {
            name = "branch";
            icon = "";
          }
          {name = "diff";}
        ];
        lualine_c = [""];
        lualine_x = [
          {
            name = "diagnostics";
            extraConfig = {update_in_insert = false;};
          }
        ];
        lualine_y = [""];
        lualine_z = [
          {name = "%l:%c";}
          {
            name = "fileformat";
            extraConfig = {icon_only = true;};
          }
        ];
      };

      tabline = {
        lualine_a = [""];
        lualine_b = [""];
        lualine_c = [
          {
            name = "windows";
            extraConfig = {
              symbols = {
                modified = "";
                readonly = "";
                unnamed = "";
                newfile = "";
              };
            };
          }
        ];
        lualine_x = [""];
        lualine_y = [""];
        lualine_z = [{name = "tabs";}];
      };

      winbar = {
        lualine_a = [""];
        lualine_b = [""];
        lualine_c = [""];
        lualine_x = [""];
        lualine_y = [""];
        lualine_z = [
          {
            name = "filetype";
            extraConfig = {
              colored = false;
              icon_only = true;
            };
          }
          {
            name = "filename";
            extraConfig = {
              file_status = true;
              shorting_target = 25;
              path = 1;

              symbols = {
                modified = "";
                readonly = "";
                unnamed = "󱧃";
                newfile = "";
              };
            };
          }
        ];
      };

      inactiveWinbar = {
        lualine_a = [""];
        lualine_b = [""];
        lualine_c = [""];
        lualine_x = [""];
        lualine_y = [""];
        lualine_z = [
          {
            name = "filetype";
            extraConfig = {
              colored = false;
              icon_only = true;
            };
          }
          {
            name = "filename";
            extraConfig = {
              file_status = true;
              path = 1;
              shorting_target = 25;

              symbols = {
                modified = "";
                readonly = "";
                unnamed = "󱧃";
                newfile = "";
              };
            };
          }
        ];
      };
    };
  };
}
