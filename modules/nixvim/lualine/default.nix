{
  lib,
  config,
  helpers,
  ...
}:
{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        globalstatus = true;

        disabled_filetypes = {
          statusline = [
            "Trouble"
          ];
          winbar = [
            "neo-tree"
            "dap-repl"
            "Trouble"
          ];
        };

        ignore_focus = [
          "neo-tree"
          "Trouble"
        ];
      };

      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "diff" ];
        lualine_x = [
          "diagnostics"
          { __unkeyed-1 = "%l:%c"; }
          "encoding"
        ];
        lualine_y = [ "filetype" ];
        lualine_z = [
          {
            __unkeyed-1 = "fileformat";
            icon_only = true;
          }
        ];
      };

      tabline = lib.mkIf (!config.plugins.bufferline.enable) {
        lualine_a = [
          {
            __unkeyed-1 = "buffers";
            symbols.alternate_file = "";
          }
        ];
        lualine_z = [ "tabs" ];
      };

      winbar = {
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
        lualine_x = [
          {
            __unkeyed-1 = "filetype";
            colored = false;
            icon_only = true;
          }
          {
            __unkeyed-1 = "filename";
            file_status = true;
            path = 3;
            shorting_target = 150;

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
