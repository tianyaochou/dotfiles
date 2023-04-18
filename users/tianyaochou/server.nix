{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
  keyFile = pkgs.fetchurl {
    url = "https://github.com/tianyaochou.keys";
    sha256 = "sha256-dlhguU7MbbyHA/auKNqM3UnJ0pPZJDReDPeLdObC5dE=";
  };
in
{
  users.users.${username} = {
    openssh = {
      authorizedKeys.keyFiles = [ keyFile ];
    };
  };
}
