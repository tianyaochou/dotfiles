{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let username = "tianyaochou"; in
{
  users.users.tianyaochou = {
    name = username;
    shell = pkgs.fish;
    home = /Users/${username};
  };
  programs.fish.enable = true;
}
