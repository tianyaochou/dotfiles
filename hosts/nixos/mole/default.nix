{ pkgs, profiles, users, ... }: {
	imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops jellyfin ]) ++ (with users.tianyaochou; [ nixos server ]);

  networking.hostName = "mole";
  networking.networkmanager.enable = true;

	boot.kernel.sysctl = {
		"net.ipv4.conf.all.forwarding" = true;
	};
}
