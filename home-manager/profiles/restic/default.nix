{ config, lib, pkgs, ... }:
let repo = "s3:http://workstation:9000/restic"; in
{
  home.packages = [ pkgs.restic ];

  programs.fish.functions.repo-restic = {
    body = "sops --config ${../../../.sops.yaml} exec-env ${./secrets.yaml} \"restic -r ${repo} $argv\"";
    wraps = "restic";
  };

  launchd.agents.restic-backup-Projects = {
    enable = true;
    config = {
      ProgramArguments = [ "/etc/profiles/per-user/tianyaochou/bin/fish"
                           "-c" "pmset -g ac | grep 'No adapter attached.' || repo-restic backup /Users/tianyaochou/Projects && repo-restic forget --keep-daily 7 --keep-monthly 12 --keep-hourly 24" ];
      StartCalendarInterval = [
        {
          Minute = 0;
        }
      ];
    };
  };
}
