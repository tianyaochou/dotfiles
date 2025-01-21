{ self, config, lib, pkgs, ... }:

{
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
