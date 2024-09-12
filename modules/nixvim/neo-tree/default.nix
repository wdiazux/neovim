{
  keymaps = [
    {
      mode = "n";
      key = "<C-n>";
      action = ":Neotree action=focus reveal toggle<CR>";
      options = {
        desc = "neo-tree: Toggle";
        silent = true;
        noremap = true;
      };
    }
  ];

  plugins.neo-tree = {
    enable = true;

    closeIfLastWindow = true;

    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        hideHidden = false;

        neverShowByPattern = [
          ".direnv"
          ".git"
        ];

        visible = true;
      };

      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };

      useLibuvFileWatcher.__raw = ''vim.fn.has "win32" ~= 1'';
    };

    window = {
      width = 40;
      autoExpandWidth = false;
    };
  };
}
