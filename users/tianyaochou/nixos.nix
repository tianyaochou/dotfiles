{ super, ... }:
{ pkgs, ... }:
let
  username = super.default.username;
in
{
  users.users.${username} = {
    isNormalUser = true;
    name = username;
    initialPassword = "password";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "jellyfin" "kvm" "libvirt" ];
  };
  programs.fish.enable = true;
}
