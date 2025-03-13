{ lib, config, ... }:
{
  plugins.mini = {
    enable = true;

    modules.git = { };
  };

  keymaps = lib.mkIf (config.plugins.mini.enable && lib.hasAttr "git" config.plugins.mini.modules) [
    {
      mode = "";
      key = "<leader>gH";
      action = "<CMD>lua MiniGit.show_range_history()<CR>";
      options = {
        desc = "Show range history";
      };
    }
    {
      mode = "n";
      key = "<leader>g.";
      action = "<CMD>lua MiniGit.show_at_cursor()<CR>";
      options = {
        desc = "Show git context";
      };
    }
  ];
}
