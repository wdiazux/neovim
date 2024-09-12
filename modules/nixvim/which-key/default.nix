{
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      action = "<cmd>WhichKey<cr>";
      key = "<leader>?";
      options = {
        desc = "Show available keys";
        silent = true;
        noremap = true;
      };
    }
  ];

  plugins.which-key = {
    enable = true;

    settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        group = "Code";
      }
      {
        __unkeyed-1 = "<leader>t";
        group = "Toggle";
      }
      {
        __unkeyed-1 = "<leader>h";
        group = "󰊢 Git";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };
}
