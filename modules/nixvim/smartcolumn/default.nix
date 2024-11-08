{
  plugins.smartcolumn = {
    enable = true;
    settings = {
      colorcolumn = "80";

      disabled_filetypes = [
        "checkhealth"
        "help"
        "lspinfo"
        "markdown"
        "neo-tree"
        "ministarter"
        "noice"
        "text"
      ];

      custom_colorcolumn = {
        go = [
          "100"
          "130"
        ];
        java = [
          "100"
          "140"
        ];
        nix = [
          "100"
          "120"
        ];
      };

      scope = "file";
    };
  };
}
