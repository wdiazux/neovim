{ ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>tu";
      action = "<cmd>UndotreeToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle undotree";
      };
    }
  ];

  plugins.undotree = {
    enable = true;

    settings = {
      CursorLine = true;
      DiffAutoOpen = true;
      DiffCommand = "diff";
      DiffpanelHeight = 10;
      HelpLine = true;
      HighlightChangedText = true;
      HighlightChangedWithSign = true;
      HighlightSyntaxAdd = "DiffAdd";
      HighlightSyntaxChange = "DiffChange";
      HighlightSyntaxDel = "DiffDelete";
      RelativeTimestamp = true;
      SetFocusWhenToggle = true;
      ShortIndicators = false;
      TreeNodeShape = "*";
      TreeReturnShape = "\\";
      TreeSplitShape = "/";
      TreeVertShape = "|";
    };
  };

  extraConfigVim = ''
    if has("persistent_undo")
       let target_path = expand('~/.cache/undodir')

        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
    endif
  '';
}
