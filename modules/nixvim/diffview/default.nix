{ config, lib, ... }:
let
  cfg = config.plugins.diffview;
in
{
  plugins.diffview.enable = true;

  keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = ''
        function()
          vim.g.diffview_enabled = not vim.g.diffview_enabled
          if vim.g.diffview_enabled then
            vim.cmd('DiffviewClose')
          else
            vim.cmd('DiffviewOpen')
          end
        end
      '';
      options = {
        desc = "Git Diff toggle";
        silent = true;
      };
    }
  ];
}
