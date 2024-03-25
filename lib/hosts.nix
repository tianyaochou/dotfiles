{ inputs, self, perSystem, withSystem, ... }: 
let home-manager-config = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { profiles = inputs.digga.lib.rakeLeaves ../home-manager/profiles; homeModules = { vscode-server = inputs.vscode-server.homeModules.default; }; };
  };
    nix-path-config = {
      nix.registry = {
        nixpkgs.flake = inputs.nixpkgs;
        dotfiles.flake = self;
      };
    };
in {
  flake.lib = {
    mkNixOSHost = {nixinate, host, system}: withSystem system ({ config, inputs', ... }: inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { profiles = inputs.digga.lib.rakeLeaves ../hosts/profiles; users = inputs.digga.lib.rakeLeaves ../users; nixpkgs = inputs.nixpkgs.legacyPackages.${system}; inputs = inputs; packages = config.packages; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        home-manager-config
        nix-path-config
        { _module.args.nixinate = nixinate; }
        host
      ];
    });
    mkMacOSHost = {nixinate, host, system}: withSystem system (ctx@{ config, inputs', ... }: inputs.nix-darwin.lib.darwinSystem {
      system = system;
      specialArgs = { profiles = inputs.digga.lib.rakeLeaves ../hosts/profiles; users = inputs.digga.lib.rakeLeaves ../users; inputs = inputs; packages = config.packages; };
      modules = [
        inputs.home-manager.darwinModules.home-manager
        home-manager-config
        nix-path-config
        { _module.args.nixinate = nixinate; }
        host
      ];
    });
  };
}