{
  plugins.treesitter = {
    enable = true;

    settings = {
      indent.enable = true;
      folding = true;
      nixvimInjections = true;

      highlight = {
        additional_vim_regex_highlighting = true;
        enable = true;
        disable = # Lua
          ''
            function(lang, bufnr)
              return vim.api.nvim_buf_line_count(bufnr) > 10000
            end
          '';
      };

      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "gnn";
          node_incremental = "grn";
          scope_incremental = "grc";
          node_decremental = "grm";
        };
      };
    };
  };
}
