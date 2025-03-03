{
  lib,
  config,
  ...
}:
{
  plugins.telescope.extensions.frecency = {
    enable =
      !config.plugins.snacks.enable
      || (config.plugins.snacks.enable && !lib.hasAttr "picker" config.plugins.snacks.settings);

    settings = {
      auto_validate = false;
    };
  };

  keymaps = lib.mkIf config.plugins.telescope.enable [
    (lib.mkIf config.plugins.telescope.extensions.frecency.enable {
      mode = "n";
      key = "<leader>fO";
      action = "<cmd>Telescope frecency<CR>";
      options = {
        desc = "Find Frequent Files";
      };
    })
  ];
}
