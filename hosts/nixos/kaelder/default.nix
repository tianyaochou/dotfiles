{ profiles, pkgs, users, ... }:
{
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops ]) ++ (with users.tianyaochou; [ nixos server ]);

  networking.hostName = "kaeler";

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
}
