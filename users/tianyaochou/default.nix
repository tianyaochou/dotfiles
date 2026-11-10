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
    sha256 = "1hv8svbqcwqq9b4lqjnqh3gdfbjkvban4sg96519q8n201qfakyz";
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
