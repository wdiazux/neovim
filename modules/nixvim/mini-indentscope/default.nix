{ lib, config, ... }:
{
  autoCmd =
    lib.mkIf (config.plugins.mini.enable && lib.hasAttr "indentscope" config.plugins.mini.modules)
      [
        {
          event = [ "FileType" ];
          pattern = [
            "help"
            "alpha"
            "dashboard"
            "ministarter"
            "neo-tree"
            "Trouble"
            "trouble"
            "lazy"
            "notify"
            "toggleterm"
          ];
          callback.__raw = ''
            function()
              vim.b.miniindentscope_disable = true
            end
          '';
        }
      ];
  plugins.mini = {
    enable = true;
    modules = {
      indentscope = lib.mkIf (
        !lib.hasAttr "indent" config.plugins.snacks.settings
        || !config.plugins.snacks.settings.indent.enabled
      ) { };
    };
  };
}
