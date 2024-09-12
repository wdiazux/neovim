{ pkgs, ... }:
{
  extraPackages = with pkgs; [ ripgrep ];

  plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native.enable = true;
      file-browser.enable = true;
      media-files.enable = true;
      ui-select.enable = true;
    };

    keymaps = {
      "<C-p>" = {
        action = "find_files";
        options.desc = "Telescope: Files";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope: Files";
      };
      "<leader>fd" = {
        action = "find_browser";
        options.desc = "Telescope: File Explorer";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Telescope: Buffers";
      };
      "<leader>fF" = {
        action = "find_files hidden=true";
        options.desc = "Telescope: Files (hidden)";
      };
      "<leader>fg" = {
        action = "live_grep";
        options.desc = "Telescope: Grep";
      };
      "<leader>fG" = {
        action = "live_grep hidden=true";
        options.desc = "Telescope: Files";
      };
      "<leader>fh" = {
        action = "git_files";
        options.desc = "Telescope: Git Files";
      };
    };
  };
}
