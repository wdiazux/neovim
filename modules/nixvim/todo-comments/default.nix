{lib, ...}:
with lib.plusultra.theme.catppuccin-mocha; {
  plugins.todo-comments = {
    enable = true;

    signs = true;
    mergeKeywords = false;
    keywords = {
      FIX = {
        icon = " ";
        color = "error";
        alt = ["FIXME" "BUG" "FIXIT" "ISSUE"];
      };
      TODO = {
        icon = " ";
        color = "todo";
      };
      HACK = {
        icon = " ";
        color = "error";
        alt = ["HACK" "DRAGONS"];
      };
      WARN = {
        icon = " ";
        color = "warning";
        alt = ["WARNING" "WARNING" "WARN"];
      };
      PERF = {
        icon = " ";
        color = "info";
        alt = ["OPTIM" "PERFORMANCE" "OPTIMIZE" "PERF" "PERFORMANCE"];
      };
      NOTE = {
        icon = " ";
        color = "hint";
        alt = ["INFO" "NOTE" "INFO"];
      };
    };
    colors = {
      error = [color11];
      warning = [color12];
      info = [color15];
      hint = [color10];
      todo = [color6];
      default = [color6];
    };
    highlight = {
      multiline = true;
      pattern = ''.*<(KEYWORDS)\s*:'';
      before = "fg";
    };
    search.pattern = ''\b(KEYWORDS):'';
  };
}
