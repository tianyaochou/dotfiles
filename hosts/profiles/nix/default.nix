{ config, lib, pkgs, inputs, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  imports = [ ./cachix ];

  nix.package = pkgs.nixVersions.latest;

  nixpkgs.config.allowUnfree = true;

  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs.outPath}"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 21d";
  };

  nix.settings = {
    # HACK: Sandbox is not working properly in macOS
    # See https://github.com/NixOS/nixpkgs/issues/116341
    sandbox = if isDarwin then false else true;
    system-features = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    allowed-users = if isDarwin then [ "@admin" ] else [ "@wheel" ];
    # Give root user and wheel group special Nix privileges.
    trusted-users = if isDarwin then [ "@admin" ] else [ "root" "@wheel" ];
    auto-optimise-store = !isDarwin; # HACK: see nix/#7273
  };

  # Generally useful nix option defaults
  nix.extraOptions = ''
      extra-experimental-features = nix-command flakes
      builders-use-substitutes = true
      min-free = 536870912
    '';
}
