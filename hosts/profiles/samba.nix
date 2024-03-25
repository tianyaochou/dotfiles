{ pkgs, ... }: {
  services.samba = {
    enable = true;
    shares = {
      xuetingTM = {
        path = "/data/xuetingTM";
        public = "no";
        writeable = "yes";
        browseable = "yes";
        "valid user" = "xueting";
        "force user" = "xueting";
        "fruit:metadata" = "stream";
        "fruit:model" = "MacSamba";
        "fruit:posix_rename" = "yes";
        "fruit:veto_appledouble" = "no";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
        "fruit:time machine" = "yes";
        "fruit:nfs_aces" = "no";
        "vfs objects" = "catia fruit streams_xattr";
        comment = "Xueting's Time Machine backup";
      };
    };
    extraConfig = ''
      wins support = yes
    '';
  };
}