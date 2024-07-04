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
          priority = 3;
          groupIndex = 1;
        }
        {
          name = "luasnip";
          priority = 5;
          groupIndex = 1;
          option.show_autosnippets = true;
        }
        {
          name = "path";
          groupIndex = 1;
        }
        {
          name = "buffer";
          priority = 2;
          groupIndex = 2;
        }
      ];
    };
  };
}
