{ pkgs, ... }:
{
  users.users.remote-builder = {
    isNormalUser = false;
    isSystemUser = true;
    group = "remote-builder";
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGMnbr+oCHf1PHg0TNI9k4GPbYpdz8IRpVefTngKO6KE root@mole"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQYnYg9yFZhYjmyq/tZnttzbuvFuOkCxzr9nM7ILXCd root@mainframe"
      ];
    };
    createHome = false;
    useDefaultShell = true;
  };

  users.groups.remote-builder = {};

  nix.settings.trusted-users = [ "remote-builder" ];
}
