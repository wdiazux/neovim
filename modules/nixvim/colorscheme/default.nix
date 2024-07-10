{ ... }:
{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      term_colors = true;
      integrations = {
        cmp = true;
        dap = true;
        gitsigns = true;
        nvimtree = true;
        telescope = true;
        treesitter = true;
      };
    };
  };
}
