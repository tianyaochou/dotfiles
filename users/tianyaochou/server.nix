{ pkgs, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
  keyFile = pkgs.fetchurl {
    url = "https://github.com/tianyaochou.keys";
    sha256 = "df4fe57000c2229c4231e96962d5da532ed7de80d84a4cc94a187386d7d668c3";
  };
in
{
  users.users.${username} = {
    openssh = {
      authorizedKeys.keyFiles = [ keyFile ];
    };
  };
}
