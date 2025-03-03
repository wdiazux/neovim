{ config, ... }:
{
  plugins.otter = {
    inherit (config.plugins.treesitter) enable;
    autoActivate = false;

    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      handle_leading_whitespace = true;
      lsp.diagnostic_update_events = [
        "BufWritePost"
        "InsertLeave"
        "TextChanged"
      ];
      buffers.set_filetype = true;
    };
  };
}
