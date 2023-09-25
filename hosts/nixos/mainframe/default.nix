{ config, pkgs, profiles, users, ... }:
{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops graphical virtualisation ]) ++ (with users.tianyaochou; [ nixos personal server develop vscode-server ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mainframe";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.05";
}