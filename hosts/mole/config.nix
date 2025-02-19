{ super, ... }:
{ pkgs, profiles, users, ... }: {
  imports = [ super.hardware-configuration ] ++ (with profiles; [ nixos nix server utils sops blocky jellyfin rsyncd ]);

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
    "net.ipv6.conf.all.forwarding" = true;
	};

  boot.postBootCommands = "echo 'none' > /sys/class/leds/green_led/trigger\necho 'none' > /sys/class/leds/blue_led/trigger";
}
