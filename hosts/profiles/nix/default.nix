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

  nix.distributedBuilds = true;
  nix.buildMachines = let
    sshKey = if isDarwin then "/Users/tianyaochou/.ssh/id_rsa" else "/root/.ssh/local-builder";
    sshUser = "remote-builder";
    protocol = "ssh-ng";
    supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
  in
  [
    {
      inherit sshKey sshUser protocol supportedFeatures;
      hostName = "mainframe";
      systems = [
          "x86_64-linux"
          "aarch64-linux"
      ];
      maxJobs = 32;
      speedFactor = 32;
    }
    {
      inherit sshKey sshUser protocol supportedFeatures;
      hostName = "gateway";
      system = "aarch64-linux";
      maxJobs = 2;
      speedFactor = 8;
    }
  ];

  nix.gc = {
    automatic = true;
    dates = lib.mkIf (config.networking.hostName == "mainframe") "monthly";
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
