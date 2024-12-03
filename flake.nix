{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-edge.url = "github:nixos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixpkgs";
    digga.inputs.nixlib.follows = "nixpkgs";
    digga.inputs.darwin.follows = "nix-darwin";
    digga.inputs.home-manager.follows = "home-manager";

    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    nixinate.url = "github:matthewcroughan/nixinate";
    nixinate.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    rk3588.url = "github:jsternberg/nixos-rk3588";
    rk3588.inputs.nixpkgs.follows = "nixpkgs";

    # Rust toolchain
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, sops-nix, nixpkgs, digga, nixinate, ... }:

    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { config, pkgs, ... }:{
        packages = import ./pkgs { inherit pkgs; };
      };

      imports = [
        inputs.devenv.flakeModule
        ./devshells/haskell.nix
        ./lib/hosts.nix
        ./flake-modules/hosts-flake.nix
      ];
    };
}
