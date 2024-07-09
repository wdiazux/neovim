{ helpers, ... }:
{
  plugins.lualine = {
    enable = true;

    globalstatus = true;

    disabledFiletypes = {
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

    ignoreFocus = [
      "dashboard"
      "NvimTree"
      "Trouble"
    ];

    componentSeparators = {
      left = "⋮";
      right = "⋮";
    };

    sectionSeparators = {
      left = "";
      right = "";
    };

    sections = {
      lualine_a = [
        {
          name = helpers.mkRaw ''
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
        { name = "diff"; }
      ];
      lualine_c = [ "" ];
      lualine_x = [
        {
          name = "diagnostics";
          extraConfig = {
            update_in_insert = true;
          };
        }
      ];
      lualine_y = [ "" ];
      lualine_z = [
        { name = "%l:%c"; }
        {
          name = "fileformat";
          extraConfig = {
            icon_only = true;
          };
        }
      ];
    };

    tabline = {
      lualine_a = [ "" ];
      lualine_b = [ "" ];
      lualine_c = [
        {
          name = "windows";
          extraConfig = {
            symbols = {
              modified = "";
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };
          };

          separator.right = "";
        }
      ];
      lualine_x = [ "" ];
      lualine_y = [ "" ];
      lualine_z = [
        {
          name = "tabs";

          separator.left = "";
        }
      ];
    };

    winbar = {
      lualine_a = [ "" ];
      lualine_b = [ "" ];
      lualine_c = [
        ""
        {
          name = helpers.mkRaw ''
            require('nvim-navic').get_location
          '';
          extraConfig = {
            cond = helpers.mkRaw ''
              require('nvim-navic').is_available
            '';
          };
        }
      ];
      lualine_x = [ "" ];
      lualine_y = [ "" ];
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
              modified = "";
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };
          };

          separator.left = "";
        }
      ];
    };

    inactiveWinbar = {
      lualine_a = [ "" ];
      lualine_b = [ "" ];
      lualine_c = [ "" ];
      lualine_x = [ "" ];
      lualine_y = [ "" ];
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
              readonly = "";
              unnamed = " ";
              newfile = " ";
            };
          };

          separator.left = "";
        }
      ];
    };
  };
}
