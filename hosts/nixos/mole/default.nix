{ pkgs, profiles, users, ... }: {
	imports = [ ./hardware-configuration.nix ] ++ (with profiles; [ nixos nix server utils sops ]) ++ (with users.tianyaochou; [ nixos server ]);

  networking.hostName = "mole";
  networking.networkmanager.enable = true;
}
