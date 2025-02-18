{ self, inputs, ... }:{
  flake = let hosts = inputs.haumea.lib.load { src = ../hosts; loader = inputs.haumea.lib.loaders.path; };
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
        mole = self.lib.mkNixOSHost {
          nixinate = {
            host = "mole";
            sshUser = "tianyaochou";
            buildOn = "local";
            substituteOnTarget = false;
            hermetic = false;
          };
          host = mole;
          system = "aarch64-linux";
        };
        kaelder = self.lib.mkNixOSHost {
          nixinate = {
            host = "kaelder";
            sshUser = "tianyaochou";
            buildOn = "remote";
            substituteOnTarget = true;
            hermetic = false;
          };
          host = kaelder;
          system = "x86_64-linux";
        };
      };

      darwinConfigurations = with hosts.darwin; {
        Tianyaos-MacBook-Pro = self.lib.mkMacOSHost {
          nixinate = {};
          host = MBP;
          system = "x86_64-darwin";
        };
      };

      apps = inputs.nixinate.nixinate.x86_64-linux self;
    };
}
