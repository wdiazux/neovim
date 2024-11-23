{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      term_colors = true;
      show_end_of_buffer = true;
      default_integrations = true;

      integrations = {
        cmp = true;
        gitsigns = true;
        diffview = true;
        illuminate = {
          enabled = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
        lsp_trouble = true;
        native_lsp = {
          enabled = true;
          underlines = {
            errors = [ "undercurl" ];
            hints = [ "undercurl" ];
            warnings = [ "undercurl" ];
            information = [ "undercurl" ];
          };
        };
        mini = {
          enabled = true;
          indentscope_color = "mocha";
        };
        navic = {
          enabled = true;
          custom_bg = "lualine";
        };
        neotree = false;
        neotest = true;
        noice = true;
        notify = true;
        vim_sneak = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
        which_key = true;
      };
    };
  };
}
