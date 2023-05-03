{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
  keyFile = pkgs.fetchurl {
    url = "https://github.com/tianyaochou.keys";
    sha256 = "sha256-/yYCn4o1uVLeGMNQkXn85Ye8BMI592my5XcKd6cb1Aw=";
  };
in
{
  users.users.${username} = {
    openssh = {
      authorizedKeys.keyFiles = [ keyFile ];
    };
  };
}
