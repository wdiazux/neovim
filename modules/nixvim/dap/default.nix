{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPackages =
    with pkgs;
    [
      coreutils
      lldb
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      gdb
      bashdb
    ];

  plugins = {
    dap = {
      enable = true;

      lazyLoad.settings = {
        cmd = [
          "DapContinue"
          "DapNew"
        ];
      };

      adapters = {
        executables = {
          bashdb = lib.mkIf pkgs.stdenv.isLinux { command = lib.getExe pkgs.bashdb; };

          cppdbg = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          gdb = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          lldb = {
            command = lib.getExe' pkgs.lldb "lldb-dap";
          };
        };

        servers = {
          codelldb = {
            port = 13000;
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = [
                "--port"
                "13000"
              ];
            };
          };
        };
      };

      configurations =
        let
          program.__raw = ''
            function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
            end
          '';

          codelldb-config = {
            inherit program;
            name = "Launch (CodeLLDB)";
            type = "codelldb";
            request = "launch";
            cwd = ''''${workspaceFolder}'';
            stopOnEntry = false;
          };

          gdb-config = {
            inherit program;
            name = "Launch (GDB)";
            type = "gdb";
            request = "launch";
            cwd = ''''${workspaceFolder}'';
            stopOnEntry = false;
          };

          lldb-config = {
            inherit program;
            name = "Launch (LLDB)";
            type = "lldb";
            request = "launch";
            cwd = ''''${workspaceFolder}'';
            stopOnEntry = false;
          };
        in
        {
          c =
            [
              lldb-config
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [
              gdb-config
            ];

          cpp =
            [
              codelldb-config
              lldb-config
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [
              gdb-config
            ];

          rust =
            [
              codelldb-config
              lldb-config
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [
              gdb-config
            ];

          sh = lib.optionals pkgs.stdenv.isLinux [
            {
              type = "bashdb";
              request = "launch";
              name = "Launch (BashDB)";
              showDebugOutput = true;
              pathBashdb = "${lib.getExe pkgs.bashdb}";
              pathBashdbLib = "${pkgs.bashdb}/share/basdhb/lib/";
              trace = true;
              file = ''''${file}'';
              program = ''''${file}'';
              cwd = ''''${workspaceFolder}'';
              pathCat = "cat";
              pathBash = "${lib.getExe pkgs.bash}";
              pathMkfifo = "mkfifo";
              pathPkill = "pkill";
              args = { };
              env = { };
              terminalKind = "integrated";
            }
          ];
        };

      signs = {
        dapBreakpoint = {
          text = "";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "";
          texthl = "dapBreakpointCondition";
        };
        dapBreakpointRejected = {
          text = "";
          texthl = "DapBreakpointRejected";
        };
        dapLogPoint = {
          text = "";
          texthl = "DapLogPoint";
        };
        dapStopped = {
          text = "";
          texthl = "DapStopped";
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.dap.enable [
      {
        __unkeyed-1 = "<leader>d";
        mode = "n";
        desc = "Debug";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.dap.enable [
    {
      mode = "n";
      key = "<leader>db";
      action = "<CMD>DapToggleBreakpoint<CR>";
      options = {
        desc = "Breakpoint toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dc";
      action = "<CMD>DapContinue<CR>";
      options = {
        desc = "Continue Debugging (Start)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function() require("dap.ui.widgets").hover() end
      '';
      options = {
        desc = "Debugger Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action = "<CMD>DapStepOut<CR>";
      options = {
        desc = "Step Out";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<CMD>DapStepOver<CR>";
      options = {
        desc = "Step Over";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dS";
      action = "<CMD>DapStepInto<CR>";
      options = {
        desc = "Step Into";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = "<CMD>DapTerminate<CR>";
      options = {
        desc = "Terminate Debugging";
        silent = true;
      };
    }
  ];
}
