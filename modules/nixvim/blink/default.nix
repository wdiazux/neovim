{
  lib,
  pkgs,
  config,
  ...
}:
{
  extraPlugins = lib.mkIf config.plugins.blink-cmp.enable (
    with pkgs.vimPlugins;
    [
      blink-compat
      blink-cmp-copilot
    ]
  );

  plugins = lib.mkMerge [
    {
      blink-cmp = {
        enable = true;
        luaConfig.pre = ''
          require('blink.compat').setup({debug = true, impersonate_nvim_cmp = true})
        '';

        settings = {
          completion = {
            accept.auto_brackets.enabled = true;
            ghost_text.enabled = true;
            documentation = {
              auto_show = true;
              window.border = "rounded";
            };
            menu = {
              border = "rounded";
              draw = {
                columns = [
                  {
                    __unkeyed-1 = "label";
                  }
                  {
                    __unkeyed-1 = "kind_icon";
                    __unkeyed-2 = "kind";
                    gap = 1;
                  }
                  { __unkeyed-1 = "source_name"; }
                ];
              };
            };
          };
          fuzzy.prebuilt_binaries = {
            download = false;
            ignore_version_mismatch = true;
          };
          appearance.use_nvim_cmp_as_default = true;
          keymap = {
            preset = "enter";
            "<A-Tab>" = [
              "snippet_forward"
              "fallback"
            ];
            "<A-S-Tab>" = [
              "snippet_backward"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
          };
          signature = {
            enabled = true;
            window.border = "rounded";
          };
          sources = {
            default = [
              # Built-in sources
              "buffer"
              "lsp"
              "path"
              "snippets"
              # Community
              "copilot"
              # cmp sources
              # TODO: migrate when available
              "calc"
              "git"
              "spell"
            ];
            providers = {
              # Built-in sources
              lsp.score_offset = 4;
              # Community
              copilot = {
                name = "copilot";
                module = "blink-cmp-copilot";
                score_offset = 5;
              };
              # cmp sources
              calc = {
                name = "calc";
                module = "blink.compat.source";
                score_offset = 2;
              };
              git = {
                name = "git";
                module = "blink.compat.source";
                score_offset = 0;
              };
              spell = {
                name = "spell";
                module = "blink.compat.source";
                score_offset = -1;
              };
            };
          };
        };
      };
    }
    (lib.mkIf config.plugins.blink-cmp.enable {
      cmp-calc.enable = true;
      cmp-git.enable = true;
      cmp-spell.enable = true;

      lsp.capabilities = ''
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      '';
    })
  ];
}
