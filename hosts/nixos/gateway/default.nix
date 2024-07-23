{ config, users, pkgs, profiles, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server sops miniflux caddy wordpress ]) ++ (with users.tianyaochou; [ nixos server ]);

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
  networking.interfaces.enp1s0.ipv6.addresses = [
    {
      address = "2a01:4f8:1c17:7051::1";
      prefixLength = 64;
    }
  ];
  networking.defaultGateway6 = { address = "fe80::1"; interface = "enp1s0"; };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  system.stateVersion = "22.11";
}
