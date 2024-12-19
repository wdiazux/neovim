{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall.namespace = "plusultra";
      alias.packages.default = "neovim";
      channels-config.allowUnfree = true;

      overlays = with inputs; [ nixvim.overlays.default ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-rfc-style;

        checks.pre-commit-check = inputs.git-hooks-nix.lib.${channels.nixpkgs.system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style = {
              enable = true;
              entry = "${channels.nixpkgs.nixfmt-rfc-style}/bin/nixfmt";
              extraPackages = [ channels.nixpkgs.nixfmt-rfc-style ];
            };
          };
        };
      };
    };
}
