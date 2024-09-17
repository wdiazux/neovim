{ config, lib, ... }:
{
  autoCmd = lib.mkIf (lib.hasAttr "indentscope" config.plugins.mini.modules) [
    {
      event = [ "FileType" ];
      pattern = [
        "help"
        "alpha"
        "ministarter"
        "neo-tree"
        "Trouble"
        "trouble"
        "mason"
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
