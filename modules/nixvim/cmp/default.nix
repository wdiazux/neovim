{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [luasnip];

  plugins.cmp = {
    enable = true;

    settings = {
      snippet.expand = "luasnip";
      mapping.__raw = builtins.readFile ./cmp-mapping.lua;

      sources = [
        {
          name = "nvim_lsp";
          groupIndex = 1;
          priority = 3;
        }
        {
          name = "luasnip";
          option = {
            show_autosnippets = true;
          };
          groupIndex = 1;
          priority = 5;
        }
        {
          name = "path";
          groupIndex = 1;
        }
        {
          name = "buffer";
          groupIndex = 2;
          priority = 2;
        }
      ];
    };
  };
}
