{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  environment = {
    shellAliases = let
      ifSudo = lib.mkIf config.security.sudo.enable;
    in {
      # nix
      nrb = ifSudo "sudo nixos-rebuild";

      # fix nixos-option for flake compat
      # nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";

      # systemd
      ctl = "systemctl";
      stl = ifSudo "sudo systemctl";
      utl = "systemctl --user";
      ut = "systemctl --user start";
      un = "systemctl --user stop";
      up = ifSudo "sudo systemctl start";
      dn = ifSudo "sudo systemctl stop";
      jtl = "journalctl";
    };
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    openFirewall = lib.mkDefault false;
  };

  programs.command-not-found.enable = false;

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
