{ pkgs, ... }:
{
  extraPackages = with pkgs; [ ripgrep ];

  plugins.telescope = {
    enable = true;

    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.idea/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };

      pickers.colorscheme.enable_preview = true;
    };

    extensions = {
      fzf-native.enable = true;
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
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Telescope: Buffers";
      };
      "<leader>fF" = {
        action = "find_files hidden=true";
        options.desc = "Telescope: Files (hidden)";
      };
      "<leader>f/" = {
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
