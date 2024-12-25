{ config, lib, ... }:
{
  plugins = {
    copilot-lua = {
      enable = true;
      panel.enabled = false;
      suggestion.enabled = false;
    };

    copilot-chat = {
      inherit (config.plugins.copilot-lua) enable;

      lazyLoad.settings.cmd = "CopilotChat";
    };

    which-key.settings.spec = lib.optionals config.plugins.copilot-chat.enable [
      {
        __unkeyed = "<leader>a";
        group = "Copilot";
        icon = "";
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.copilot-chat.enable (
    lib.concatMap
      (keymap: [
        {
          mode = "n";
          inherit (keymap) key action;
          options = {
            inherit (keymap) desc;
          };
        }
      ])
      [
        {
          key = "<leader>ac";
          action = "<cmd>CopilotChat<CR>";
          desc = "Copilot Chat";
        }
        {
          key = "<leader>aq";
          action.__raw = ''
            function()
              local input = vim.fn.input("Quick Chat: ")
              if input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
              end
            end
          '';
          desc = "Quick Chat";
        }
        {
          key = "<leader>ah";
          action.__raw = ''
            function()
              local actions = require("CopilotChat.actions")
              require("CopilotChat.integrations.telescope").pick(actions.help_actions())
            end
          '';
          desc = "Help Actions";
        }
        {
          key = "<leader>ap";
          action.__raw = ''
            function()
              local actions = require("CopilotChat.actions")
              require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end
          '';
          desc = "Prompt Actions";
        }
      ]
  );
}
