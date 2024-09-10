{ helpers, config, ... }:
{
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

      on_attach = helpers.mkRaw ''
        function(bufnr)
          local which_key = require("which-key")
          local gitsigns = package.loaded.gitsigns

        	local function prev_hunk()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
          end

         local function next_hunk()
           if vim.wo.diff then return ']c' end
           vim.schedule(function() gitsigns.next_hunk() end)
           return '<Ignore>'
         end

         which_key.register({
           ["[c"] = { prev_hunk, "Previous hunk" },
           ["]c"] = { next_hunk, "Next hunk" },
         }, { buffer = bufnr })

         which_key.register({
           h = {
             name = "Git Hunk",
             s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
             r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
             S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
             u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
             R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
             p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
             b = { function() gitsigns.blame_line { full = true } end, "Blame Line" },
             d = { "<cmd>Gitsigns diffthis<cr>", "Diff" },
             D = { function() gitsigns.diffthis("~") end, "Diff (~)" },
           },
           t = {
             name = "Toggle",
             b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Current Line Blame" },
             d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle Deleted" }
           },
         }, { prefix = "<leader>", buffer = bufnr })
        end
      '';
    };
  };
}
