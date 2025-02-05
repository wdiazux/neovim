{
  lib,
  pkgs,
  config,
  ...
}:
{
  extraPackages = with pkgs; [
    gh
    wordnet
  ];
  extraPlugins = lib.mkIf config.plugins.blink-cmp.enable (
    with pkgs.vimPlugins;
    [
      blink-cmp-dictionary
      blink-cmp-git
      blink-cmp-spell
      blink-copilot
      blink-emoji-nvim
      blink-ripgrep-nvim
    ]
  );

  plugins = lib.mkMerge [
    {
      blink-cmp = {
        enable = true;

        settings = {
          completion = {
            ghost_text.enabled = true;
            documentation = {
              auto_show = true;
              window.border = "rounded";
            };
            list.selection = {
              auto_insert = false;
              preselect = false;
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
                components = {
                  kind_icon = {
                    ellipsis = false;
                    text.__raw = ''
                      function(ctx)
                        local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                        -- Check for both nil and the default fallback icon
                        if not kind_icon or kind_icon == '󰞋' then
                          -- Use our configured kind_icons
                          return require('blink.cmp.config').appearance.kind_icons[ctx.kind] or ""
                        end
                        return kind_icon
                      end,
                      -- Optionally, you may also use the highlights from mini.icons
                      highlight = function(ctx)
                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                        return hl
                      end
                    '';
                  };
                };
              };
            };
          };
          fuzzy.prebuilt_binaries = {
            download = false;
            ignore_version_mismatch = true;
          };
          appearance = {
            use_nvim_cmp_as_default = true;
            kind_icons.Copilot = "";
          };
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
          snippets.preset = "mini_snippets";
          sources = {
            default = [
              # Built-in sources
              "buffer"
              "lsp"
              "path"
              "snippets"
              # Community
              "copilot"
              "dictionary"
              "emoji"
              "git"
              "spell"
              # cmp sources
              # TODO: migrate when available
              "calc"
              "zsh"
            ];
            providers =
              {
                # Built-in sources
                lsp.score_offset = 4;
                # Community sources
                copilot = {
                  name = "copilot";
                  module = "blink-copilot";
                  async = true;
                  score_offset = 3;
                };
                dictionary = {
                  name = "Dict";
                  module = "blink-cmp-dictionary";
                  min_keyword_length = 3;
                };
                emoji = {
                  name = "Emoji";
                  module = "blink-emoji";
                  score_offset = 1;
                };
                git = {
                  name = "Git";
                  module = "blink-cmp-git";
                  enabled = true;
                  score_offset = 100;
                  should_show_items.__raw = ''
                    function()
                      return vim.o.filetype == 'gitcommit' or vim.o.filetype == 'markdown'
                    end
                  '';
                };
                ripgrep = {
                  name = "Ripgrep";
                  module = "blink-ripgrep";
                  async = true;
                  score_offset = 1;
                };
                spell = {
                  name = "Spell";
                  module = "blink-cmp-spell";
                  score_offset = 1;
                };
              }
              // lib.optionalAttrs config.plugins.blink-compat.enable {
                # Cmp sources
                calc = {
                  name = "calc";
                  module = "blink.compat.source";
                  score_offset = 2;
                };
                npm = {
                  name = "npm";
                  module = "blink.compat.source";
                  score_offset = -3;
                };
                zsh = {
                  name = "zsh";
                  module = "blink.compat.source";
                  score_offset = -3;
                };
              };
          };
        };
      };

      blink-compat.enable = true;
    }
    (lib.mkIf config.plugins.blink-cmp.enable {
      cmp-calc.enable = true;
      cmp-zsh.enable = true;

      lsp.capabilities = # Lua
        ''
          capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
        '';
    })
  ];
}
