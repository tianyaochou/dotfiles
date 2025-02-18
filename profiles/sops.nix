{ config, lib, pkgs, ... }:
{

  inherit (if pkgs.stdenv.isLinux then { sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; } else {});

  environment.systemPackages = [ pkgs.sops pkgs.ssh-to-age ];
}
