{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let
  username = "tianyaochou";
  email = "tianyaochou@fastmail.com";
in
{
  users.users.${username} = {
    isNormalUser = true;
    name = username;
    initialPassword = "password";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  programs.fish.enable = true;
}
