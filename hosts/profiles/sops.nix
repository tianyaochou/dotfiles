{ config, lib, pkgs, ... }:

{
  sops.age.sshKeyPaths = if pkgs.stdenv.isLinux then [ "/etc/ssh/ssh_host_ed25519_key" ] else [];

  environment.systemPackages = [ pkgs.sops pkgs.ssh-to-age ];
}
