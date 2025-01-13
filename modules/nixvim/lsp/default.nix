{
  lib,
  config,
  ...
}:
{
  extraConfigLuaPre = ''
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

    require('lspconfig.ui.windows').default_options = {
      border = "rounded"
    }
  '';

  plugins = {
    lsp-format.enable = !config.plugins.conform-nvim.enable && config.plugins.lsp.enable;
    lsp-signature.enable = config.plugins.lsp.enable;

    lsp = {
      enable = true;
      inlayHints = true;

      keymaps = {
        silent = true;

        diagnostic = {
          "<leader>l[" = "goto_prev";
          "<leader>l]" = "goto_next";
          "<leader>lH" = "open_float";
        };

        extra = [
          {
            action.__raw = ''vim.lsp.buf.format'';
            mode = "v";
            key = "<leader>lf";
            options = {
              silent = true;
              buffer = false;
              desc = "Format selection";
            };
          }
          {
            action.__raw = "peek_definition";
            mode = "n";
            key = "<leader>lp";
            options.desc = "Preview definition";
          }
          {
            action.__raw = "peek_type_definition";
            mode = "n";
            key = "<leader>lP";
            options.desc = "Preview type definition";
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
        astro.enable = true;
        bashls.enable = true;
        biome.enable = true;
        cssls.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nushell.enable = true;
        pyright.enable = true;
        ruff.enable = true;
        sqls.enable = true;
        taplo.enable = true;
        ts_ls.enable = !config.plugins.typescript-tools.enable;
        yamlls.enable = true;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>l";
        group = "LSP";
        icon = " ";
      }
      {
        __unkeyed-1 = "<leader>la";
        desc = "Code Action";
      }
      {
        __unkeyed-1 = "<leader>ld";
        desc = "Definition";
      }
      {
        __unkeyed-1 = "<leader>lD";
        desc = "References";
      }
      {
        __unkeyed-1 = "<leader>lf";
        desc = "Format";
      }
      {
        __unkeyed-1 = "<leader>l[";
        desc = "Prev";
      }
      {
        __unkeyed-1 = "<leader>l]";
        desc = "Next";
      }
      {
        __unkeyed-1 = "<leader>lt";
        desc = "Type Definition";
      }
      {
        __unkeyed-1 = "<leader>li";
        desc = "Implementation";
      }
      {
        __unkeyed-1 = "<leader>lh";
        desc = "Lsp Hover";
      }
      {
        __unkeyed-1 = "<leader>lH";
        desc = "Diagnostic Hover";
      }
      {
        __unkeyed-1 = "<leader>lr";
        desc = "Rename";
      }
    ];
  };
}
