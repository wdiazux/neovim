{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      term_colors = true;
      show_end_of_buffer = true;
      default_integrations = true;

      integrations = {
        diffview = true;
        fidget = true;
        headlines = true;
        hop = true;
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        leap = true;
        lsp_trouble = true;
        mason = true;
        native_lsp = {
          enabled = true;
          underlines = {
            errors = [ "undercurl" ];
            hints = [ "undercurl" ];
            warnings = [ "undercurl" ];
            information = [ "undercurl" ];
          };
        };
        navic = {
          enabled = true;
          custom_bg = "lualine";
        };
        neotree = false;
        neotest = true;
        noice = true;
        notify = true;
        overseer = true;
        sandwich = true;
        symbols_outline = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
        which_key = true;
      };
    };
  };
}
