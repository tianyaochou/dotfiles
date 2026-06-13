{
  self,
  super,
  home,
  ...
}: {
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
  keyFile = builtins.fetchurl {
    url = "https://github.com/tianyaochou.keys";
    sha256 = "14rf06nqq1jv814ydmnj6h2li1jdk8arilivzzphkx9294311qw7";
  };

  hosts = {
    Tianyaos-MacBook-Pro = {
      profiles = [super.darwin];
      homeProfiles = [home.suites.workstation];
    };
    mainframe = {
      profiles = [super.nixos super.server];
      homeProfiles = [home.suites.workstation];
    };
    mole = {
      profiles = [super.nixos super.server];
      homeProfiles = [];
    };
    kaelder = {
      profiles = [super.nixos super.server];
      homeProfiles = [];
    };
    gateway = {
      profiles = [super.nixos super.server];
      homeProfiles = [];
    };
  };
}
