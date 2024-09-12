{ helpers, ... }:
let
  get_bufnrs.__raw = ''
    function()
      local buf_size_limit = 1024 * 1024 -- 1MB size limit
      local bufs = vim.api.nvim_list_bufs()
      local valid_bufs = {}
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf)) < buf_size_limit then
          table.insert(valid_bufs, buf)
        end
      end
      return valid_bufs
    end
  '';
in
{
  opts.completeopt = [
    "menu"
    "menuone"
  ];

  plugins = {
    luasnip.enable = true;
    cmp-emoji.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;

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

        snippet.expand = "luasnip";

        sources = [
          {
            name = "nvim_lsp";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_document_symbol";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "treesitter";
            priority = 850;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "luasnip";
            priority = 750;
          }
          {
            name = "buffer";
            priority = 500;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "path";
            priority = 300;
          }
          {
            name = "cmdline";
            priority = 300;
          }
          {
            name = "spell";
            priority = 300;
          }
          {
            name = "git";
            priority = 250;
          }
          {
            name = "tmux";
            priority = 250;
          }
          {
            name = "emoji";
            priority = 100;
          }
        ];
      };
    };
  };
  extraConfigLua = ''
    luasnip = require("luasnip")
    local cmp = require'cmp'
  '';
}
