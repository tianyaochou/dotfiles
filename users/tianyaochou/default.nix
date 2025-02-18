{ self, super, home, ... }:
{
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
  keyFile = builtins.fetchurl {
    url = "https://github.com/tianyaochou.keys";
    sha256 = "df4fe57000c2229c4231e96962d5da532ed7de80d84a4cc94a187386d7d668c3";
  };

  hosts = {
    Tianyaos-MacBook-Pro = {
      profiles = [ super.darwin ];
      homeProfiles = [ home.suites.workstation ];
    };
    mainframe = {
      profiles = [ super.nixos super.server ];
      homeProfiles = [ home.suites.workstation ];
    };
    mole = {
      profiles = [ super.nixos super.server ];
      homeProfiles = [];
    };
    kaelder = {
      profiles = [ super.nixos super.server ];
      homeProfiles = [];
    };
    gateway = {
      profiles = [ super.nixos super.server ];
      homeProfiles = [];
    };
  };
}
