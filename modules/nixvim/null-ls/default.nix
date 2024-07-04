{...}: {
  plugins.none-ls = {
    enable = true;
    settings.extraOptions.enableLspFormat = true;
    sources.formatting.prettier = {
      enable = true;
      disableTsServerFormatter = true;
    };
  };
}
