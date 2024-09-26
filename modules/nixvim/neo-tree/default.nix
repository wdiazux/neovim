{ lib, config, ... }:
{
  keymaps = lib.mkIf config.plugins.neo-tree.enable [
    {
      mode = "n";
      key = "<leader>E";
      action = ":Neotree action=focus reveal toggle<CR>";
      options = {
        desc = "Explorer toggle";
        silent = true;
      };
    }
  ];

  plugins.neo-tree = {
    enable = true;

    closeIfLastWindow = true;

    sources = [
      "filesystem"
      "buffers"
      "git_status"
      "document_symbols"
    ];

    defaultComponentConfigs = {
      indent = {
        withExpanders = true;
        expanderCollapsed = "";
        expanderExpanded = "";
        expanderHighlight = "NeoTreeExpander";
      };
      gitStatus.symbols = {
        added = " ";
        conflict = "󰩌 ";
        deleted = "󱂥";
        ignored = " ";
        modified = " ";
        renamed = "󰑕";
        staged = "󰩍";
        unstaged = "";
        untracked = "";
      };
    };

    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        hideHidden = false;

        neverShowByPattern = [
          ".direnv"
          ".git"
          ".idea"
        ];

        visible = true;
      };

      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };

      bindToCwd = false;
      useLibuvFileWatcher.__raw = ''vim.fn.has "win32" ~= 1'';
    };

    window = {
      width = 40;
      autoExpandWidth = false;
    };
  };
}
