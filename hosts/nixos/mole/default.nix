{ pkgs, profiles, users, ... }: {
  imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops blocky ]) ++ (with users.tianyaochou; [ nixos server ]);

  fileSystems."/" = {
    device = "/dev/mmcblk0p2";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/mmcblk0p1";
    fsType = "vfat";
  };

  networking.hostName = "mole";
  networking.networkmanager.enable = true;

	boot.kernel.sysctl = {
		"net.ipv4.conf.all.forwarding" = true;
	};
}
