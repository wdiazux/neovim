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
    if (os.getenv('SSH_TTY') ~= nil)
    then
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
          ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
      }
    end
  '';
}
