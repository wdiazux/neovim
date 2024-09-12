{ ... }:
{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      term_colors = true;
      default_integrations = true;

      dim_inactive = {
        enabled = false;
        percentage = 0.25;
      };
    };
  };
}
