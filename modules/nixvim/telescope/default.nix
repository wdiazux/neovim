{
  lib,
  config,
  ...
}:
{
  imports = [
    ./file-browser.nix
    ./frecency.nix
    ./fzf-native.nix
    ./live_grep.nix
    ./manix.nix
    ./ui-select.nix
    ./undo.nix
  ];

  plugins.telescope = {
    enable = true;

    lazyLoad.settings.cmd =
      [ "Telescope" ]
      ++ lib.optionals config.plugins.noice.enable [
        "Noice telescope"
      ];

    highlightTheme = "Catppuccin Macchiato";

    # Better version available through fzf-lua
    keymaps = lib.mkIf (!config.plugins.fzf-lua.enable) {
      "<leader>f'" = {
        action = "marks";
        options.desc = "View marks";
      };
      "<leader>f/" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Fuzzy find in current buffer";
      };
      "<leader>f<CR>" = {
        action = "resume";
        options.desc = "Resume action";
      };
      "<leader>fa" = {
        action = "autocommands";
        options.desc = "View autocommands";
      };
      "<leader>fc" = {
        action = "commands";
        options.desc = "View commands";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "View buffers";
      };
      # "<leader>fc" = {
      #   action = "grep_string";
      #   options.desc = "Grep string";
      # };
      "<leader>fd" = {
        action = "diagnostics";
        options.desc = "View diagnostics";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find files";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "View help tags";
      };
      "<leader>fk" = {
        action = "keymaps";
        options.desc = "View keymaps";
      };
      "<leader>fm" = {
        action = "man_pages";
        options.desc = "View man pages";
      };
      "<leader>fo" = {
        action = "oldfiles";
        options.desc = "View old files";
      };
      "<leader>fr" = {
        action = "registers";
        options.desc = "View registers";
      };
      "<leader>fs" = {
        action = "lsp_document_symbols";
        options.desc = "Search symbols";
      };
      "<leader>fq" = {
        action = "quickfix";
        options.desc = "Search quickfix";
      };
      # "<leader>gC" = {
      #   action = "git_bcommits";
      #   options.desc = "View git bcommits";
      # };
      "<leader>gB" = {
        action = "git_branches";
        options.desc = "View git branches";
      };
      "<leader>gC" = {
        action = "git_commits";
        options.desc = "View git commits";
      };
      "<leader>gs" = {
        action = "git_status";
        options.desc = "View git status";
      };
      "<leader>gS" = {
        action = "git_stash";
        options.desc = "View git stashes";
      };
    };

    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };

      pickers = {
        colorscheme = {
          enable_preview = true;
        };
      };
    };
  };

  keymaps = lib.mkIf config.plugins.telescope.enable (
    [
      {
        mode = "n";
        key = "<leader>fF";
        action.__raw = ''
          function()
            vim.cmd('Telescope find_files hidden=true no_ignore=true')
          end
        '';
        options = {
          desc = "Find all files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fW";
        action.__raw = ''
          function()
            vim.cmd('Telescope live_grep additional_args={"--hidden","--no-ignore"}')
          end
        '';
        options = {
          desc = "Find words in all files";
          silent = true;
        };
      }
    ]
    # Better version available through fzf-lua
    ++ lib.optionals (!config.plugins.fzf-lua.enable) [
      {
        mode = "n";
        key = "<leader>fC";
        action.__raw = ''
          function()
            vim.cmd(string.format('Telescope find_files prompt_title="Config Files" cwd="%s" follow=true', vim.fn.stdpath("config")))
          end
        '';
        options = {
          desc = "Find config files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fT";
        action.__raw = ''
          function()
            vim.cmd('Telescope colorscheme enable_preview=true')
          end
        '';
        options = {
          desc = "Find theme";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>f?";
        action.__raw = ''
          function()
            vim.cmd('Telescope live_grep grep_open_files=true')
          end
        '';
        options = {
          desc = "Find words in all open buffers";
          silent = true;
        };
      }
    ]
  );
}
