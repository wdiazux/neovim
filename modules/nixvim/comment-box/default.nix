{ lib, config, ... }:
let
  cfg = config.plugins.comment-box;
in
{
  plugins = {
    comment-box.enable = true;

    which-key.settings.spec = lib.optionals cfg.enable [
      {
        __unkeyed = "<leader>lc";
        group = "Comment-box";
        icon = " ";
      }
    ];
  };

  keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>lcd";
      action = "<cmd>CBd<cr>";
      options = {
        desc = "Delete a box";
      };
    }
    {
      mode = "n";
      key = "<leader>lcb";
      action = "<cmd>CBccbox<cr>";
      options = {
        desc = "Box Title";
      };
    }
    {
      mode = "n";
      key = "<leader>lct";
      action = "<cmd>CBllline<cr>";
      options = {
        desc = "Titled Line";
      };
    }
    {
      mode = "n";
      key = "<leader>lcl";
      action = "<cmd>CBline<cr>";
      options = {
        desc = "Simple Line";
      };
    }
  ];
}
