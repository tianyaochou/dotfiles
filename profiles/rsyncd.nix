{pkgs, ...}: {
  services.rsyncd = {
    enable = true;
    settings = {
      sections = {
        music = {
          path = "/media/Music/";
          uid = "jellyfin";
          gid = "jellyfin";
          "read only" = false;
        };
      };
    };
  };
}
