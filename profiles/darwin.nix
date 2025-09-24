{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      m-cli
    ];

    shellAliases = {
      nrb = "sudo darwin-rebuild switch --flake";
    };
  };
}
