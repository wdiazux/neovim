{ lib, ... }:
{
  config = {
    vimAlias = true;
    withNodeJs = true;

    luaLoader.enable = true;

    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;

      # Custom for toggles
      disable_diagnostics = false;
      disable_autoformat = false;
      spell_enabled = true;
      colorizing_enabled = 1;
      first_buffer_opened = false;
    };

    opts = {
      updatetime = 100;

      # Line numbers
      relativenumber = true;
      number = true;
      mouse = "a";
      mousemodel = "extend";
      splitbelow = true;
      splitright = true;

      swapfile = false;
      modeline = true;
      modelines = 100;
      undofile = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      cursorline = true;
      cursorcolumn = false;
      signcolumn = "yes";
      colorcolumn = "100";
      laststatus = 3;
      fileencoding = "utf-8";
      termguicolors = true;
      spelllang = lib.mkDefault [
        "en_us"
      ];
      spell = true;
      wrap = true;

      # Tab options
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      autoindent = true;

      textwidth = 0;

      # Folding
      foldlevel = 99; # Folds with a level higher than this number will be closed
      foldcolumn = "1";
      foldenable = true;
      foldlevelstart = -1;
      fillchars = {
        horiz = "━";
        horizup = "┻";
        horizdown = "┳";
        vert = "┃";
        vertleft = "┫";
        vertright = "┣";
        verthoriz = "╋";

        eob = " ";
        diff = "╱";

        fold = " ";
        foldopen = "";
        foldclose = "";

        msgsep = "‾";
      };

      breakindent = true;
      cmdheight = 0;
      copyindent = true;
      history = 1000;
      infercase = true;
      linebreak = true;
      preserveindent = true;
      pumheight = 10;
      showmode = false;
      showtabline = 2;
      timeoutlen = 500;
      title = true;
      virtualedit = "block";
      writebackup = false;

      synmaxcol = 240;
      showmatch = true;
      matchtime = 1;
      startofline = true;
      report = 9001;
    };
  };
}
