{ config, lib, ... }:
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

    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      options = {
        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          __unkeyed-3 = "copilot-chat";
          __unkeyed-4 = "ministarter";
          __unkeyed-5 = "Avante";
          __unkeyed-6 = "AvanteInput";
          __unkeyed-7 = "trouble";
          __unkeyed-8 = "dapui_scopes";
          __unkeyed-9 = "dapui_breakpoints";
          __unkeyed-10 = "dapui_stacks";
          __unkeyed-11 = "dapui_watches";
          __unkeyed-12 = "dapui_console";
          __unkeyed-13 = "dashboard";
          __unkeyed-14 = "snacks_dashboard";
          winbar = [
            "aerial"
            "dap-repl"
            "neotest-summary"
          ];
        };

        globalstatus = true;
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];

        lualine_x = [
          { __raw = ''Snacks.profiler.status()''; }
          "diagnostics"

          # Show active language server
          {
            __unkeyed-1.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = "";
            color.fg = "#ffffff";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];

        lualine_y = [
          {
            __unkeyed-1 = "aerial";
            inherit cond;

            # -- The separator to be used to separate symbols in status line.
            sep = " ) ";

            # -- The number of symbols to render top-down. In order to render only 'N' last
            # -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
            # -- be used in order to render only current symbol.
            depth.__raw = "nil";

            # -- When 'dense' mode is on, icons are not rendered near their symbols. Only
            # -- a single icon that represents the kind of current symbol is rendered at
            # -- the beginning of status line.
            dense = false;

            # -- The separator to be used to separate symbols in dense mode.
            dense_sep = ".";

            # -- Color the symbol icons.
            colored = true;
          }
        ];

        lualine_z = [
          {
            __unkeyed-1 = "location";
            inherit cond;
          }
        ];
      };

      tabline = lib.mkIf (!config.plugins.bufferline.enable) {
        lualine_a = [
          # NOTE: not high priority since i use bufferline now, but should fix left separator color
          {
            __unkeyed-1 = "buffers";
            symbols.alternate_file = "";
          }
        ];
        lualine_z = [ "tabs" ];
      };

      winbar = {
        lualine_c = [
          {
            __unkeyed-1 = "navic";
            inherit cond;
          }
        ];

        # TODO: Need to dynamically hide/show component so navic takes precedence on smaller width
        lualine_x = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
            # Shorten path names to fit navic component
            shorting_target = 150;
          }
        ];
      };
    };
  };
}
