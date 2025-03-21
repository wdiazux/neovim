{
  lib,
  pkgs,
  config,
  ...
}:
let
  worktreeEnabled = builtins.elem pkgs.vimPlugins.git-worktree-nvim config.extraPlugins;
  worktreeTelescopeEnabled = worktreeEnabled && config.plugins.telescope.enable;
in
{
  extraPlugins = with pkgs.vimPlugins; [ git-worktree-nvim ];

  plugins = {
    telescope.enabledExtensions = lib.optionals worktreeTelescopeEnabled [ "git_worktree" ];

    which-key.settings.spec = lib.optionals worktreeTelescopeEnabled [
      {
        __unkeyed-1 = "<leader>gW";
        group = "Worktree";
        icon = "󰙅 ";
      }
    ];
  };

  keymaps = lib.mkIf worktreeTelescopeEnabled [
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope git_worktree<CR>";
      options.desc = "Git Worktree";
    }
    {
      mode = "n";
      key = "<leader>gWc";
      action = "<cmd>Telescope git_worktree create_git_worktree<CR>";
      options = {
        desc = "Create worktree";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gWs";
      action = "<cmd>Telescope git_worktree git_worktree<CR>";
      options = {
        desc = "Switch / Delete worktree";
        silent = true;
      };
    }
  ];
}
