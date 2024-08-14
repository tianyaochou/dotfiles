{ self, config, lib, pkgs, ... }:

{
  # Recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  services.nix-daemon.enable = true;
  nix.configureBuildUsers = true;

  environment = {
    systemPackages = with pkgs; [
      m-cli
    ];

    shellAliases = {
      nrb = "darwin-rebuild switch --flake";
    };
  };
}
