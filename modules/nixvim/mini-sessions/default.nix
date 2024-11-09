{ lib, config, ... }:
{
  autoCmd = lib.mkIf (lib.hasAttr "sessions" config.plugins.mini.modules) [
    {
      event = [ "FileType" ];
      pattern = [
        "help"
        "alpha"
        "neo-tree"
        "Trouble"
        "trouble"
        "notify"
        "toggleterm"
        "lazyterm"
      ];
      callback.__raw = ''
        function()
          vim.b.minisessions_disable = true
        end
      '';
    }
  ];
  plugins.mini = {
    enable = true;
    modules.sessions = { };
  };
}
