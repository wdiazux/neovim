{ helpers, ... }:
{
  plugins = {
    cmp = {
      enable = true;

      cmdline =
        let
          search = {
            mapping =
              helpers.mkRaw # lua

                "cmp.mapping.preset.cmdline()";
            sources = [ { name = "buffer"; } ];
          };
        in
        {
          "/" = search;
          "?" = search;
          ":" = {
            mapping =
              helpers.mkRaw # lua

                "cmp.mapping.preset.cmdline()";
            sources = [ { name = "cmdline"; } ];
          };
        };

      settings = {
        experimental = {
          ghost_text = true;
        };

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-j>" = "cmp.mapping.scroll_docs(4)";
          "<C-k>" = "cmp.mapping.scroll_docs(-4)";
          "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          "<C-n>" =
            helpers.mkRaw # lua

              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end
              '';
          "<C-p>" =
            helpers.mkRaw # lua

              ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end
              '';
        };

        snippet = {
          expand = ''function(args) require("luasnip").lsp_expand(args.body) end'';
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
