{ config, lib, ... }:
{
  plugins.snacks = {
    enable = true;

    settings = {
      bigfile = {
        enabled = true;
        size = 1024 * 1024; # 1MB
        setup.__raw = ''
          function(ctx)
            ${lib.optionalString config.plugins.indent-blankline.enable ''require("ibl").setup_buffer(0, { enabled = false })''}
            ${lib.optionalString (lib.hasAttr "indentscope" config.plugins.mini.modules) ''vim.b.miniindentscope_disable = true''}
            ${lib.optionalString config.plugins.illuminate.enable ''require("illuminate").pause_buf()''}

            -- Disable line numbers and relative line numbers
            vim.cmd("setlocal nonumber norelativenumber")

            -- Syntax highlighting
            vim.schedule(function()
              vim.bo[ctx.buf].syntax = ctx.ft
            end)

            -- Disable matchparen
            vim.cmd("let g:loaded_matchparen = 1")

            -- Disable cursor line and column
            vim.cmd("setlocal nocursorline nocursorcolumn")

            -- Disable folding
            vim.cmd("setlocal nofoldenable")

            -- Disable sign column
            vim.cmd("setlocal signcolumn=no")

            -- Disable swap file and undo file
            vim.cmd("setlocal noswapfile noundofile")

            -- Disable mini animate
            vim.b.minianimate_disable = true
          end
        '';
      };
      bufdelete.enabled = true;
      gitbrowse.enabled = true;
      indent.enabled = true;
      lazygit.enabled = true;
      scroll.enabled = true;
      statuscolumn = {
        enabled = true;

        folds = {
          open = true;
          git_hl = config.plugins.gitsigns.enable;
        };
      };
    };
  };

  keymaps =
    [
      (lib.mkIf
        (
          config.plugins.snacks.enable
          && lib.hasAttr "gitbrowse" config.plugins.snacks.settings
          && config.plugins.snacks.settings.gitbrowse.enabled
        )
        {
          mode = "n";
          key = "<leader>go";
          action = "<cmd>lua Snacks.gitbrowse()<CR>";
          options = {
            desc = "Open file in browser";
          };
        }
      )
      (lib.mkIf
        (
          config.plugins.snacks.enable
          && lib.hasAttr "lazygit" config.plugins.snacks.settings
          && config.plugins.snacks.settings.lazygit.enabled
        )
        {
          mode = "n";
          key = "<leader>gg";
          action = "<cmd>lua Snacks.lazygit()<CR>";
          options = {
            desc = "Open lazygit";
          };
        }
      )
    ]
    ++ lib.optionals
      (
        config.plugins.snacks.enable
        && lib.hasAttr "bufdelete" config.plugins.snacks.settings
        && config.plugins.snacks.settings.bufdelete.enabled
      )
      [
        {
          mode = "n";
          key = "<leader>c";
          action = ''<cmd>lua Snacks.bufdelete.delete()<cr>'';
          options = {
            desc = "Close buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>bc";
          action = ''<cmd>lua Snacks.bufdelete.other()<cr>'';
          options = {
            desc = "Close all buffers but current";
          };
        }
        {
          mode = "n";
          key = "<leader>bC";
          action = ''<cmd>lua Snacks.bufdelete.all()<cr>'';
          options = {
            desc = "Close all buffers";
          };
        }
      ];
}
