{ pkgs, ... }:
{
  clipboard = {
    register = "unnamedplus";
    providers.wl-copy = {
      enable = true;
      package = pkgs.wl-clipboard;
    };
  };
}
