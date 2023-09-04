{ config, users, pkgs, profiles, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops miniflux ]) ++ (with users.tianyaochou; [ nixos server ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gateway";

  # security.acme.acceptTerms = true;

  # services.grocy = {
  #   enable = true;
  #   hostName = "gateway.mgourd.com";
  # };

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 7878;
    passwordFile = builtins.toFile "passwdfile" "test";
  };

  networking.firewall.allowedTCPPorts = [ 7878 ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  system.stateVersion = "22.11";
}
