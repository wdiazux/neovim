{
  plugins.navic = {
    enable = true;

    settings.lsp = {
      autoAttach = true;
      preference = [
        "nixd"
        "clangd"
        "tsserver"
      ];
    };
  };
}
