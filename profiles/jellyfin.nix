{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
  };

  users.users.jellyfin = {};
}
