{
  colorscheme = "catppuccin";

  colorschemes.catppuccin = {
    enable = true;

    lazyLoad.enable = true;

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
          virtual_text = {
            errors = [ "italic" ];
            hints = [ "italic" ];
            warnings = [ "italic" ];
            information = [ "italic" ];
          };
          underlines = {
            errors = [ "undercurl" ];
            hints = [ "undercurl" ];
            warnings = [ "undercurl" ];
            information = [ "undercurl" ];
          };
          inlay_hints.background = true;
        };
        mini = {
          enabled = true;
          indentscope_color = "mocha";
        };
        navic.enabled = true;
        neotree = false;
        neotest = true;
        noice = true;
        notify = true;
        vim_sneak = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
        treesitter = true;
        which_key = true;
      };
    };
  };
}
