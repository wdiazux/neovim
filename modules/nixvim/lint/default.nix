{
  lib,
  pkgs,
  config,
  ...
}:
{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      bash = [ "shellcheck" ];
      css = lib.mkIf (!config.plugins.lsp.servers.stylelint_lsp.enable) [ "stylelint" ];
      fish = [ "fish" ];
      go = [ "golangcilint" ];
      html = [ "htmlhint" ];
      javascript = lib.mkIf (!config.plugins.lsp.servers.biome.enable) [ "biomejs" ];
      json = [ "jsonlint" ];
      lua = [ "luacheck" ];
      make = [ "checkmake" ];
      markdown = [ "markdownlint" ];
      nix = [
        "deadnix"
        "nix"
      ];
      # FIXME: causes ruff errors
      # python = [ "pylint" ];
      sh = [ "shellcheck" ];
      sql = [ "sqlfluff" ];
      typescript = lib.mkIf (!config.plugins.lsp.servers.biome.enable) [ "biomejs" ];
      # TODO:
      # xml = [ "xmllint" ];
      yaml = [ "yamllint" ];
    };

    linters = {
      biomejs.cmd = lib.getExe pkgs.biome;
      checkmake.cmd = lib.getExe pkgs.checkmake;
      checkstyle.cmd = lib.getExe pkgs.checkstyle;
      cmakelit.cmd = lib.getExe' pkgs.cmake-format "cmake-lint";
      deadnix.cmd = lib.getExe pkgs.deadnix;
      fish.cmd = lib.getExe pkgs.fish;
      htmlhint.cmd = lib.getExe pkgs.htmlhint;
      jsonlint.cmd = lib.getExe' pkgs.nodePackages.jsonlint "jsonlint";
      luacheck.cmd = lib.getExe' pkgs.luaPackages.luacheck "luacheck";
      markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
      pylint.cmd = lib.getExe pkgs.pylint;
      shellcheck.cmd = lib.getExe pkgs.shellcheck;
      sqlfluff.cmd = lib.getExe pkgs.sqlfluff;
      stylelint.cmd = lib.getExe pkgs.stylelint;
      yamllint.cmd = lib.getExe pkgs.yamllint;
    };
  };
}
