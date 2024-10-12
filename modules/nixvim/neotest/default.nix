{ config, lib, ... }:
{
  plugins = {
    neotest = {
      enable = true;

      settings = {
        adapters = lib.optionals config.plugins.rustaceanvim.enable [
          # Lua
          ''require('rustaceanvim.neotest')''
        ];
      };

      adapters = {
        bash.enable = config.plugins.neotest.enable;
        deno.enable = config.plugins.neotest.enable;
        go.enable = config.plugins.neotest.enable;
        playwright.enable = config.plugins.neotest.enable;
        plenary.enable = config.plugins.neotest.enable;
        python.enable = config.plugins.neotest.enable;
        # rust.enable = config.plugins.neotest.enable;
        zig.enable = config.plugins.neotest.enable;
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.neotest.enable [
      {
        __unkeyed = "<leader>n";
        group = "Neotest";
        icon = "󰙨";
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.neotest.enable [
    {
      mode = "n";
      key = "<leader>dn";
      action.__raw = ''
        function()
          require("neotest").run.run({strategy = "dap"})
        end
      '';
      options = {
        desc = "Neotest Debug";
      };
    }
    {
      mode = "n";
      key = "<leader>na";
      action = "<CMD>Neotest attach<CR>";
      options = {
        desc = "Attach";
      };
    }
    {
      mode = "n";
      key = "<leader>nd";
      action.__raw = ''
        function()
          require("neotest").run.run({strategy = "dap"})
        end
      '';
      options = {
        desc = "Debug";
      };
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = "<CMD>Neotest output<CR>";
      options = {
        desc = "Output";
      };
    }
    {
      mode = "n";
      key = "<leader>no";
      action = "<CMD>Neotest output-panel<CR>";
      options = {
        desc = "Output Panel toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>nr";
      action = "<CMD>Neotest run<CR>";
      options = {
        desc = "Run (Nearest Test)";
      };
    }
    {
      mode = "n";
      key = "<leader>nR";
      action.__raw = ''
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end
      '';
      options = {
        desc = "Run (File)";
      };
    }
    {
      mode = "n";
      key = "<leader>ns";
      action = "<CMD>Neotest stop<CR>";
      options = {
        desc = "Stop";
      };
    }
    {
      mode = "n";
      key = "<leader>nt";
      action = "<CMD>Neotest summary<CR>";
      options = {
        desc = "Summary toggle";
      };
    }
  ];
}
