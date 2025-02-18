{ self, ... }:
{ config, profiles, pkgs, users, ... }:
{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops restic ]);

  systemd.network.enable = true;
  sops.secrets."ip" = {
    sopsFile = ./secrets.yaml;
    reloadUnits = [ "systemd-networkd.service" ];
  };
  sops.secrets."gateway" = {
    sopsFile = ./secrets.yaml;
    reloadUnits = [ "systemd-networkd.service" ];
  };
  sops.templates."enX0-config" = {
    content = ''
      [Match]
      Name=enX0
      [Network]
      DNS=1.1.1.1 8.8.8.8
      [Address]
      Address=${config.sops.placeholder."ip"}
      [Route]
      Gateway=${config.sops.placeholder."gateway"}
    '';
    owner = "systemd-network";
  };
  environment.etc."systemd/network/20-enX0.network".source = config.sops.templates."enX0-config".path;

  networking.hostName = "kaelder";

  fileSystems."/" = {
    device = "/dev/xvda3";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/xvda2";
    fsType = "ext4";
  };
  fileSystems."/nix" = {
    device = "/dev/xvdb1";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
    ];
    neededForBoot = true;
  };
  fileSystems."/data" = {
    device = "/dev/xvdb1";
    fsType = "btrfs";
    options = [
      "subvol=data"
      "compress=zstd"
    ];
  };
}
