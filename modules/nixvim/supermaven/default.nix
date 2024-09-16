{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ supermaven-nvim ];

  extraConfigLua = ''
    require("supermaven-nvim").setup({
    	disable_inline_completion = true,
    	disable_keymaps = true,
    })
  '';
}
