{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
in
{
  users.users.${username} = {
    extraGroups = [ "networkmanager" "libvirtd" ];
    packages = with pkgs; [
      firefox
      kate
    ];
  };
}
