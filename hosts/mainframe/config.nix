{super, ...}: {profiles, ...}: {
  imports = [./hardware-configuration.nix] ++ (with profiles; [nixos nix server remote-builder utils sops graphical virtualisation dual-boot minio]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  networking.hostName = super.meta.hostname;
  networking.networkmanager.enable = true;

  networking.interfaces.enp9s0.wakeOnLan.enable = true;

  system.stateVersion = "23.05";
}
