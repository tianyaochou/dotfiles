{ self, pkgs, system, config, lib, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
in
{
  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      firefox
    ];
  };
}
