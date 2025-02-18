{ self, config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      m-cli
    ];

    shellAliases = {
      nrb = "darwin-rebuild switch --flake";
    };
  };
}
