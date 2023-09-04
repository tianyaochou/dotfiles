{ self, inputs, ... }:{
  flake = let hosts = inputs.digga.lib.rakeLeaves ../hosts;
    in {
      nixosConfigurations = with hosts.nixos; {
        mainframe = self.lib.mkNixOSHost {
          nixinate = {
            host = "mainframe";
            sshUser = "tianyaochou";
            buildOn = "remote";
            substituteOnTarget = true;
            hermetic = false;
          };
          host = mainframe;
          system = "x86_64-linux";
        };
        workstation = self.lib.mkNixOSHost {
          host = workstation;
          nixinate = {
            host = "workstation";
            sshUser = "tianyaochou";
            buildOn = "remote";
            substituteOnTarget = true;
            hermetic = false;
          };
          system = "x86_64-linux";
        };
        gateway = self.lib.mkNixOSHost {
          nixinate = {
            host = "gateway.mgourd.me";
            sshUser = "tianyaochou";
            buildOn = "remote"; # valid args are "local" or "remote"
            substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
            hermetic = false;
          };
          host = gateway;
          system = "aarch64-linux";
        };
      };

      darwinConfigurations = with hosts.darwin; {
        Tianyaos-MBP = self.lib.mkMacOSHost {}
            Tianyaos-MBP
            "x86_64-darwin";
      };

      apps = inputs.nixinate.nixinate.x86_64-darwin self;
    };
}