{

  plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      nixpkgs.expr = "import <nixpkgs> {}";
      formatting.command = [ "nixfmt" ];
      diagnostic.suppress = [ "sema-extra-with" ];
      options = {
        nixos.expr = ''
          let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).nixosConfigurations; in (builtins.head (builtins.attrValues configs)).options
        '';
        home_manager.expr = ''
          let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).homeConfigurations; in (builtins.head (builtins.attrValues configs)).options
        '';
      };
    };
  };
}
