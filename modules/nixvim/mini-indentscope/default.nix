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
    modules.indentscope = { };
  };
}
