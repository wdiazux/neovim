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
        bash.enable = true;
        deno.enable = true;
        dotnet = {
          enable = true;

          settings = {
            dap = {
              args = {
                justMyCode = false;
              };
            };
          };
        };
        go.enable = true;
        java.enable = true;
        # NOTE: just run NeotestJava setup
        # java.settings = {
        # Not sure why this wasn't working
        # junit_jar =
        #   pkgs.fetchurl
        #     {
        #       url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.1/junit-platform-console-standalone-1.10.1.jar";
        #       hash = "sha256-tC6qU9E1dtF9tfuLKAcipq6eNtr5X0JivG6W1Msgcl8=";
        #     }
        #     .outPath;
        # };
        jest.enable = true;
        playwright.enable = true;
        plenary.enable = true;
        python.enable = true;
        # rust.enable = true;
        zig.enable = true;
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
