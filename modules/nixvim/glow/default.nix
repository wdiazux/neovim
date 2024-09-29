{ config, lib, ... }:
{
  plugins = {
    glow = {
      enable = true;
      settings.border = "single";
    };

    which-key.settings.spec = [
      {
        __unkeyed = "<leader>p";
        mode = "n";
        group = "Preview";
        icon = " ";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.glow.enable [
    {
      mode = "n";
      key = "<leader>pg";
      action = "<cmd>Glow<CR>";
      options.desc = "Glow (Markdown)";
    }
  ];
}
