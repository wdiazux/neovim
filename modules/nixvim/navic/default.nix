{
  plugins.navic = {
    enable = true;

    lazyLoad.settings.event = "DeferredUIEnter";

    settings.lsp = {
      autoAttach = true;
      preference = [ "tsserver" ];
    };
  };
}
