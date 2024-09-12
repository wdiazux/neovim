{ config, ... }:
{
  keymaps = [
    {
      key = "<leader>hs";
      action = "<cmd>Gitsigns stage_hunk<cr>";
      options = {
        desc = "Stage Hunk";
        silent = true;
      };
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>hr";
      action = "<cmd>Gitsigns reset_hunk<cr>";
      options = {
        desc = "Reset Hunk";
        silent = true;
      };
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>hS";
      mode = "n";
      action = "<cmd>Gitsigns stage_buffer<cr>";
      options = {
        desc = "Stage Buffer";
        silent = true;
      };
    }
    {
      key = "<leader>hu";
      mode = "n";
      action = "<cmd>Gitsigns undo_stage_hunk<cr>";
      options = {
        desc = "Undo stage Hunk";
        silent = true;
      };
    }
    {
      key = "<leader>hR";
      mode = "n";
      action = "<cmd>Gitsigns reset_buffer<cr>";
      options = {
        desc = "Reset Buffer";
        silent = true;
      };
    }
    {
      key = "<leader>hd";
      mode = "n";
      action = "<cmd>Gitsigns diffthis<cr>";
      options = {
        desc = "Diff";
        silent = true;
      };
    }
    {
      key = "<leader>tb";
      mode = "n";
      action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
      options = {
        desc = "Toggle Current Line Blame";
        silent = true;
      };
    }
    {
      key = "<leader>td";
      mode = "n";
      action = "<cmd>Gitsigns toggle_deleted<cr>";
      options = {
        desc = "Toggle Deleted";
        silent = true;
      };
    }
    {
      key = "<leader>hD";
      mode = "n";
      action.__raw = ''
        function() gitsigns.diffthis("~") end
      '';
      options = {
        desc = "Diff (~)";
        silent = true;
      };
    }
    {
      key = "<leader>hb";
      mode = "n";
      action.__raw = ''
        function() require("gitsigns").blame_line{full=true} end
      '';
      options = {
        desc = "Blame Line";
        silent = true;
      };
    }
    {
      key = "[c";
      mode = "n";
      action.__raw = ''
        function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() require("gitsigns").prev_hunk() end)
          return '<Ignore>'
        end
      '';
      options = {
        desc = "Previous Hunk";
        silent = true;
      };
    }
    {
      key = "]c";
      mode = "n";
      action.__raw = ''
        function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require("gitsigns").next_hunk() end)
          return '<Ignore>'
        end
      '';
      options = {
        desc = "Next Hunk";
        silent = true;
      };
    }
  ];

  plugins.gitsigns = {
    enable = true;

    settings = {
      current_line_blame = true;
      trouble = config.plugins.trouble.enable;

      signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "-";
        topdelete.text = "-";
        changedelete.text = "~";
        untracked.text = "┆";
      };
    };
  };
}
