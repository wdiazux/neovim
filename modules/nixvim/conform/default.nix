{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;

    lazyLoad.settings = {
      cmd = [ "ConformInfo" ];
      event = [ "BufWrite" ];
    };

    luaConfig.pre = ''
      local slow_format_filetypes = {}
    '';

    settings = {
      format_on_save = # Lua
        ''
          function(bufnr)
               if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                 return
               end

                -- Disable autoformat for slow filetypes
               if slow_format_filetypes[vim.bo[bufnr].filetype] then
                 return
               end

                -- Disable autoformat for files in a certain path
               local bufname = vim.api.nvim_buf_get_name(bufnr)
               if bufname:match("/node_modules/") or bufname:match("/.direnv/") then
                 return
               end

               local function on_format(err)
                 if err and err:match("timeout$") then
                   slow_format_filetypes[vim.bo[bufnr].filetype] = true
                 end
               end

               return { timeout_ms = 200, lsp_fallback = true }, on_format
              end 
        '';

      format_after_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { lsp_fallback = true }
          end
        '';

      # NOTE:
      # Conform will run multiple formatters sequentially
      # [ "1" "2" "3"]
      # Add stop_after_first to run only the first available formatter
      # { "__unkeyed-1" = "foo"; "__unkeyed-2" = "bar"; stop_after_first = true; }
      # Use the "*" filetype to run formatters on all filetypes.
      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      formatters_by_ft = {
        bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        css = [ "stylelint" ];
        fish = [ "fish_indent" ];
        javascript = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          timeout_ms = 2000;
          stop_after_first = true;
        };
        json = [ "jq" ];
        lua = [ "stylua" ];
        markdown = [ "deno_fmt" ];
        nix = [ "nixfmt" ];
        python = [
          "isort"
          "ruff"
        ];
        sh = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        sql = [ "sqlfluff" ];
        terraform = [ "terraform_fmt" ];
        toml = [ "taplo" ];
        typescript = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettierd";
          timeout_ms = 2000;
          stop_after_first = true;
        };
        xml = [
          "xmlformat"
          "xmllint"
        ];
        yaml = [ "yamlfmt" ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };

      formatters = {
        biome.command = lib.getExe pkgs.biome;
        isort.command = lib.getExe pkgs.isort;
        jq.command = lib.getExe pkgs.jq;
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
        prettierd.command = lib.getExe pkgs.prettierd;
        ruff.command = lib.getExe pkgs.ruff;
        shellcheck.command = lib.getExe pkgs.shellcheck;
        shfmt.command = lib.getExe pkgs.shfmt;
        shellharden.command = lib.getExe pkgs.shellharden;
        sqlfluff.command = lib.getExe pkgs.sqlfluff;
        squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
        stylelint.command = lib.getExe pkgs.stylelint;
        stylua.command = lib.getExe pkgs.stylua;
        taplo.command = lib.getExe pkgs.taplo;
        terraform_fmt.command = lib.getExe pkgs.terraform;
        xmlformat.command = lib.getExe pkgs.xmlformat;
        yamlfmt.command = lib.getExe pkgs.yamlfmt;
      };
    };
  };
}
