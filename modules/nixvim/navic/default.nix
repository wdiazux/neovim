{
  plugins.navic = {
    enable = true;

    settings = {
      highlight = true;
      separator = "  ";

      lsp = {
        autoAttach = true;

        preference = [ "nixd" ];
      };
    };
  };
}
