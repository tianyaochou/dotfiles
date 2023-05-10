{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.sops pkgs.ssh-to-age ];
}
