{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
in
{
  users.users.${username} = {
    isNormalUser = true;
    name = username;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };
}
