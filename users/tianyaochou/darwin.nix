{super, ...}: {pkgs, ...}: let
  username = super.default.username;
in {
  users.users.tianyaochou = {
    name = username;
    shell = pkgs.fish;
    home = /Users/${username};
  };
  programs.fish.enable = true;
}
