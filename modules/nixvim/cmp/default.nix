{ helpers, ... }:
{
  plugins = {
    luasnip.enable = true;

    cmp = {
      enable = true;

      cmdline =
        let
          search = {
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
            sources = [ { name = "buffer"; } ];
          };
        in
        {
          "/" = search;
          "?" = search;
          ":" = {
            mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
            sources = [ { name = "cmdline"; } ];
          };
        };

      settings = {
        experimental.ghost_text = true;

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-j>" = "cmp.mapping.scroll_docs(4)";
          "<C-k>" = "cmp.mapping.scroll_docs(-4)";
          "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          "<C-n>" = helpers.mkRaw ''
            function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end
          '';
          "<C-p>" = helpers.mkRaw ''
            function(fallback)
              local luasnip = require("luasnip")
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end
          '';
        };

        snippet = {
          expand = "luasnip";
        };

        sources = [
          {
            name = "luasnip";
            groupIndex = 1;
            priority = 5;
          }
          {
            name = "nvim_lsp";
            groupIndex = 1;
            priority = 3;
          }
          { name = "omni"; }
          { name = "path"; }
          { name = "cmdline"; }
          { name = "buffer"; }
          { name = "dictionary"; }
        ];
      };
    };
  };
}
