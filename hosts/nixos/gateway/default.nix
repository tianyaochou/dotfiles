{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gateway";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  system.stateVersion = "22.11";
}
