{ pkgs, ... }:
{
  services.rsyncd = {
    enable = true;
    settings = {
      music = {
        path = "/media/Music/";
        uid = "jellyfin";
        gid = "jellyfin";
        "read only" = false;
      };
    };
  };
}
