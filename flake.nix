{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-edge.url = "github:nixos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";

    devenv.url = "github:cachix/devenv";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    deploy-rs.url = "github:serokell/deploy-rs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    git-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";

    rk3588.url = "github:jsternberg/nixos-rk3588";
    rk3588.inputs.nixpkgs.follows = "nixpkgs";

    # Rust toolchain
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      imports = [
        inputs.devenv.flakeModule
        inputs.git-hooks-nix.flakeModule
        ./flake-modules/hosts.nix
        ./flake-modules/profiles.nix
        ./flake-modules/users.nix
        ./flake-modules/home.nix
        ./flake-modules/toplevel-config.nix
        ./pkgs/default.nix
      ];

      perSystem = {
        config,
        pkgs,
        system,
        lib,
        ...
      }: {
        packages = {
          deploy-rs = inputs.deploy-rs.packages.${system}.default;
        };

        devShells.default = config.pre-commit.devShell;

        pre-commit.settings.hooks.alejandra.enable = true;
        pre-commit.settings.hooks.trim-trailing-whitespace.enable = true;
      };
    };
}
