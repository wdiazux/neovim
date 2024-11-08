{ pkgs, ... }:
{
  clipboard = {
    register = "unnamedplus";
    providers.wl-copy = {
      enable = true;
      package = pkgs.wl-clipboard;
    };
  };
  extraConfigLua = ''
    function my_paste(reg)
      return function(lines)
        local content = vim.fn.getreg('"')
        return vim.split(content, '\n')
      end
    end

    if (os.getenv('SSH_TTY') ~= nil)
    then
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ['+'] = my_paste,
          ['*'] = my_paste,
        },
      }
    end
  '';
}
