{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
in
{
  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      firefox
      kate
    ];
  };
}
