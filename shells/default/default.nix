{
  mkShell,
  system,
  inputs,
  ...
}:
mkShell { inherit (inputs.self.checks.${system}.git-hooks-nix) shellHook; }
