{ helpers, ... }:
{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        globalstatus = true;

        disabled_filetypes = {
          statusline = [
            "dashboard"
            "NvimTree"
            "Trouble"
          ];
          winbar = [
            "dashboard"
            "NvimTree"
            "Trouble"
          ];
        };

        ignore_focus = [
          "dashboard"
          "NvimTree"
          "Trouble"
        ];
      };

      sections = {
        lualine_a = [
          {
            __unkeyed-1 = helpers.mkRaw ''
              function()
                return ""
              end
            '';
          }
        ];
        lualine_b = [
          {
            __unkeyed-1 = "branch";
            icon = "";
          }
          "diff"
        ];
        lualine_c = [ "" ];
        lualine_x = [
          {
            __unkeyed-1 = "diagnostics";
            update_in_insert = true;
          }
        ];
        lualine_y = [ "" ];
        lualine_z = [
          { __unkeyed-1 = "%l:%c"; }
          {
            __unkeyed-1 = "fileformat";
            icon_only = true;
          }
        ];
      };

      tabline = {
        lualine_a = [ "" ];
        lualine_b = [ "" ];
        lualine_c = [
          {
            __unkeyed-1 = "windows";
            symbols = {
              modified = "";
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };
          }
        ];
        lualine_x = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [
          {
            __unkeyed-1 = "tabs";
          }
        ];
      };

      winbar = {
        lualine_a = [ "" ];
        lualine_b = [ "" ];
        lualine_c = [
          ""
          {
            __unkeyed-1 = helpers.mkRaw ''
              require('nvim-navic').get_location
            '';
            cond = helpers.mkRaw ''
              require('nvim-navic').is_available
            '';
          }
        ];
        lualine_x = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [
          {
            __unkeyed-1 = "filetype";
            colored = false;
            icon_only = true;
          }
          {
            __unkeyed-1 = "filename";
            file_status = true;
            shorting_target = 25;
            path = 1;

            symbols = {
              modified = "";
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };

          }
        ];
      };

      inactive_winbar = {
        lualine_a = [ "" ];
        lualine_b = [ "" ];
        lualine_c = [ "" ];
        lualine_x = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [
          {
            __unkeyed-1 = "filetype";
            colored = false;
            icon_only = true;
          }
          {
            __unkeyed-1 = "filename";
            file_status = true;
            path = 1;
            shorting_target = 25;

            symbols = {
              modified = "";
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };

          }
        ];
      };
    };
  };
}
