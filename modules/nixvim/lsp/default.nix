{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [ nixfmt-rfc-style ];

  extraConfigLuaPre = # Lua
    ''
      local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }

      for type, icon in pairs(diagnostic_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local function preview_location_callback(_, result)
        if result == nil or vim.tbl_isempty(result) then
          vim.notify('No location found to preview')
          return nil
        end
      local buf, _ = vim.lsp.util.preview_location(result[1])
        if buf then
          local cur_buf = vim.api.nvim_get_current_buf()
          vim.bo[buf].filetype = vim.bo[cur_buf].filetype
        end
      end

      function peek_definition()
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
      end

      local function peek_type_definition()
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
      end
    '';

  autoCmd = [
    (lib.mkIf config.plugins.lsp.servers.helm-ls.enable {
      event = "FileType";
      pattern = "helm";
      command = "LspRestart";
    })
  ];

  plugins = {
    helm.enable = true;
    lsp-lines.enable = true;
    lsp-format.enable = lib.mkIf (!config.plugins.conform-nvim.enable) true;

    nvim-jdtls = {
      enable = true;
      configuration = "$XDG_CACHE_HOME/jdtls/config";
      data.__raw = "vim.fn.stdpath 'cache' .. '/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')";
    };

    lsp = {
      enable = true;

      keymaps = {
        silent = true;
        diagnostic = {
          # Navigate in diagnostics
          "<leader>l[" = "goto_prev";
          "<leader>l]" = "goto_next";
          # TODO: fix theme of float
          "<leader>lH" = "open_float";
        };

        extra = [
          {
            action.__raw = ''
              function()
                vim.lsp.buf.format({
                  async = true,
                  range = {
                    ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                    ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
                  }
                })
              end
            '';
            mode = "v";
            key = "<leader>lf";
            options = {
              desc = "Format selection";
            };
          }
          {
            action.__raw = "peek_definition";
            mode = "n";
            key = "<leader>lp";
            options = {
              desc = "Preview definition";
            };
          }
          {
            action.__raw = "peek_type_definition";
            mode = "n";
            key = "<leader>lP";
            options = {
              desc = "Preview type definition";
            };
          }
        ];

        lspBuf = {
          "<leader>la" = "code_action";
          "<leader>ld" = "definition";
          "<leader>lD" = "references";
          "<leader>lf" = "format";
          "<leader>lh" = "hover";
          "<leader>li" = "implementation";
          "<leader>lr" = "rename";
          "<leader>lt" = "type_definition";
        };
      };

      servers = {
        bashls = {
          enable = true;

          filetypes = [
            "sh"
            "bash"
          ];
        };

        ccls = {
          enable = true;
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
          ];

          initOptions.compilationDatabaseDirectory = "build";
        };

        # TODO: see what further configuration might be needed
        cmake = {
          enable = true;
          filetypes = [ "cmake" ];
        };

        clangd = {
          enable = true;
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
          ];
        };

        csharp-ls = {
          enable = true;
          filetypes = [ "cs" ];
        };

        cssls = {
          enable = true;
          filetypes = [
            "css"
            "less"
            "scss"
          ];
        };

        dockerls = {
          enable = true;
          filetypes = [ "dockerfile" ];
        };

        eslint = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
        };

        gdscript = {
          enable = true;
          filetypes = [
            "gd"
            "gdscript"
            "gdscript3"
          ];
        };

        harper-ls.enable = true;

        helm-ls = {
          enable = true;
          filetypes = [ "helm" ];
        };

        html = {
          enable = true;
          filetypes = [ "html" ];
        };

        java-language-server = {
          enable = !config.plugins.nvim-jdtls.enable;
          filetypes = [ "java" ];
        };

        jdt-language-server = {
          inherit (config.plugins.nvim-jdtls) enable;
          filetypes = [ "java" ];
        };

        jsonls = {
          enable = true;
          filetypes = [
            "json"
            "jsonc"
          ];
        };

        lua-ls = {
          enable = true;
          filetypes = [ "lua" ];
        };

        marksman = {
          enable = true;
          filetypes = [ "markdown" ];
        };

        nixd = {
          enable = true;
          filetypes = [ "nix" ];
          settings = {
            nixpkgs.expr = "import <nixpkgs> {}";
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).nixosConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
              home_manager.expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).homeConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
          };
        };

        pyright = {
          enable = true;
          filetypes = [ "python" ];
        };

        ruff = {
          enable = true;
          filetypes = [ "python" ];
        };

        rust-analyzer = {
          enable = lib.mkIf (!config.plugins.rustaceanvim.enable) true;
          filetypes = [ "rust" ];
          installCargo = true;
          installRustc = true;

          settings = {
            diagnostics = {
              enable = true;
              styleLints.enable = true;
            };

            files = {
              excludeDirs = [
                ".direnv"
                "rust/.direnv"
              ];
            };

            inlayHints = {
              bindingModeHints.enable = true;
              closureStyle = "rust_analyzer";
              closureReturnTypeHints.enable = "always";
              discriminantHints.enable = "always";
              expressionAdjustmentHints.enable = "always";
              implicitDrops.enable = true;
              lifetimeElisionHints.enable = "always";
              rangeExclusiveHints.enable = true;
            };

            procMacro = {
              enable = true;
            };
          };
        };

        sqls = {
          enable = true;
          filetypes = [ "sql" ];
        };

        taplo = {
          enable = true;
          filetypes = [ "toml" ];
        };

        ts-ls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
        };

        yamlls = {
          enable = true;
          filetypes = [ "yaml" ];
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed = "<leader>l";
        group = "LSP";
        icon = " ";
      }
      {
        __unkeyed = "<leader>la";
        desc = "Code Action";
      }
      {
        __unkeyed = "<leader>ld";
        desc = "Definition";
      }
      {
        __unkeyed = "<leader>lD";
        desc = "References";
      }
      {
        __unkeyed = "<leader>lf";
        desc = "Format";
      }
      {
        __unkeyed = "<leader>l[";
        desc = "Prev";
      }
      {
        __unkeyed = "<leader>l]";
        desc = "Next";
      }
      {
        __unkeyed = "<leader>lt";
        desc = "Type Definition";
      }
      {
        __unkeyed = "<leader>li";
        desc = "Implementation";
      }
      {
        __unkeyed = "<leader>lh";
        desc = "Lsp Hover";
      }
      {
        __unkeyed = "<leader>lH";
        desc = "Diagnostic Hover";
      }
      {
        __unkeyed = "<leader>lr";
        desc = "Rename";
      }
    ];
  };
}
