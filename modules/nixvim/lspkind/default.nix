{ config, lib, ... }:
{
  plugins.lspkind = {
    enable = true;

    cmp = lib.mkIf config.plugins.cmp.enable {
      enable = true;

      menu = {
        buffer = "";
        calc = "";
        cmdline = "";
        chatpt = "󱜙";
        emoji = "󰞅";
        git = "";
        luasnip = "󰩫";
        nvim_lsp = "";
        nvim_lua = "";
        path = "";
        spell = "";
        treesitter = "󰔱";
        nixpkgs_maintainers = "";
      };
    };
  };
}
