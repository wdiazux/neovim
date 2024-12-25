{
  lib,
  config,
  helpers,
  ...
}:
let
  cond.__raw = ''
    function()
      local buf_size_limit = 1024 * 1024 -- 1MB size limit
      if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
        return false
      end

      return true
    end
  '';
in
{
  plugins.lualine = {
    enable = true;

    lazyLoad.settings.event = "BufEnter";

    settings = {
      options = {
        globalstatus = true;

        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          winbar = [
            "neotest-summary"
          ];
        };
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
