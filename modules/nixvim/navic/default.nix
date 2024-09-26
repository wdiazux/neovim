{
  plugins.navic = {
    enable = true;

    settings.lsp = {
      autoAttach = true;
      preference = [
        "clangd"
        "ts-ls"
      ];
    };
  };
}
