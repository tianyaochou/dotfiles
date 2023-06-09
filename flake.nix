{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    digga.url = "github:divnix/digga";
    digga.inputs.nixlib.follows = "nixpkgs";
    digga.inputs.darwin.follows = "darwin";
    digga.inputs.home-manager.follows = "home-manager";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
    nixinate.url = "github:matthewcroughan/nixinate";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, digga, darwin, nix-doom-emacs, nixinate, sops-nix, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      hosts = digga.lib.rakeLeaves ./hosts;
      users = digga.lib.rakeLeaves ./users;
      profiles = digga.lib.rakeLeaves ./hosts/profiles;
      hmProfiles = digga.lib.rakeLeaves ./home-manager/profiles;
    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = with hosts.nixos; {
        workstation = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; hmProfiles = hmProfiles; };
          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            workstation
            {
              _module.args.nixinate = {
                host = "workstation";
                sshUser = "tianyaochou";
                buildOn = "remote";
                substituteOnTarget = true;
                hermetic = false;
              };
            }
          ] ++ (with profiles; [ profiles.nixos nix server utils sops minio])
            ++ (with users.tianyaochou; [ nixos personal server develop ]);
        };
        gateway = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs outputs; hmProfiles = hmProfiles; };
          modules = [
            gateway
            sops-nix.nixosModules.sops
            {
              _module.args.nixinate = {
                host = "gateway.mgourd.me";
                sshUser = "tianyaochou";
                buildOn = "remote"; # valid args are "local" or "remote"
                substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
                hermetic = false;
              };
            }
          ] ++ (with profiles; [ profiles.nixos nix server utils sops miniflux ])
            ++ (with users.tianyaochou; [ nixos server ]);
        };
      };

      darwinConfigurations = with hosts.darwin; {
        Tianyaos-MBP = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = { inherit inputs outputs; hmProfiles = hmProfiles; };
          modules = [
            home-manager.darwinModules.home-manager
            Tianyaos-MBP
          ] ++ (with profiles; [ profiles.darwin nix utils sops ])
            ++ (with users.tianyaochou; [ users.tianyaochou.darwin develop ]);
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # FIXME replace with your username@hostname
        "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/home.nix
          ];
        };
      };
      apps = nixinate.nixinate.x86_64-darwin self;
    };
}
