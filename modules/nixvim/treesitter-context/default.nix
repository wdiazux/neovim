{ lib, config, ... }:
{
  plugins.treesitter-context = {
    enable = true;
    settings = {
      max_lines = 4;
      min_window_height = 40;
      separator = "-";
    };
  };

  keymaps = lib.mkIf config.plugins.treesitter-context.enable [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>TSContextToggle<cr>";
      options.desc = "Treesitter Context toggle";
    }
  ];
}
