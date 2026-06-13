{pkgs, ...}: {
  users.users.remote-builder = {
    isNormalUser = false;
    isSystemUser = true;
    group = "remote-builder";
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGMnbr+oCHf1PHg0TNI9k4GPbYpdz8IRpVefTngKO6KE root@mole"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINzb/n/4ZwKhwoTJzcZqG6sWPEzaxUQGa5LpwCcBjxly root@kaelder"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDxN9rTixlu4L7ZK1dcvLtuiKFMK0QX19v9efhd9h/V"
      ];
    };
    createHome = false;
    useDefaultShell = true;
  };

  users.groups.remote-builder = {};

  nix.settings.trusted-users = ["remote-builder"];
}
