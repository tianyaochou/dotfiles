{ config, pkgs, profiles, users, ... }:
{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops graphical virtualisation dual-boot minio samba ]) ++ (with users.tianyaochou; [ nixos personal server develop vscode-server ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "mainframe";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.05";
}