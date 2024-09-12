{
  plugins.auto-session = {
    enable = true;

    bypassSessionSaveFileTypes = [
      "dashboard"
      "neo-tree"
    ];

    autoRestore.enabled = true;
    autoSave.enabled = true;
    autoSession = {
      enabled = true;
      createEnabled = true;
      useGitBranch = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      action = "<cmd>Telescope session-lens<cr>";
      key = "<leader>fs";
      options.desc = "Find Session";
    }
  ];
}
