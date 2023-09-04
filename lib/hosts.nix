{ self, inputs, perSystem, ... }: 
let home-manager-config = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { profiles = inputs.digga.lib.rakeLeaves ../home-manager/profiles; homeModules = {nix-doom-emacs = inputs.nix-doom-emacs.hmModule; };};
  };
    nix-path-config = {
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    };
in {
  flake.lib = {
    mkNixOSHost = {nixinate, host, system}: inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { profiles = inputs.digga.lib.rakeLeaves ../hosts/profiles; users = inputs.digga.lib.rakeLeaves ../users; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        home-manager-config
        nix-path-config
        { _module.args.nixinate = nixinate; }
        host
      ];
    };
    mkMacOSHost = {nixinate, host, system}: inputs.nix-darwin.lib.darwinSystem {
      system = system;
      specialArgs = { profiles = inputs.digga.lib.rakeLeaves ../hosts/profiles; users = inputs.digga.lib.rakeLeaves ../users; };
      modules = [
        inputs.home-manager.darwinModules.home-manager
        home-manager-config
        nix-path-config
        { _module.args.nixinate = nixinate; }
        host
      ];
    };
  };
}