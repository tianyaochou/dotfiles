{ config, lib, pkgs, ... }:
let repo = "s3:http://mainframe:9000/restic";
    remote = "rest:http://kaelder:8000/mbp"; in
{
  home.packages = [ pkgs.restic ];

  programs.fish.functions.repo-restic = {
    body = "sops --config ${../../../.sops.yaml} exec-env ${./secrets.yaml} \"restic -r ${repo} $argv\"";
    wraps = "restic";
  };

  
  programs.fish.functions.remote-restic = {
    body = "sops --config ${../../../.sops.yaml} exec-env ${./secrets.yaml} \"restic -r ${remote} $argv\"";
    wraps = "restic";
  };

  launchd.agents.restic-backup-Projects = let
    exclude_file = (pkgs.writeText "exclude-list" ''
      .*
      Applications
      tianyaochou/Library
      Virtual Machines.localized
      
    '');
  in {
    enable = true;
    config = {
      ProgramArguments = [ "/run/current-system/sw/bin/fish"
                           "-c" "pmset -g ac | grep 'No adapter attached.' || remote-restic backup /Users/tianyaochou/ --exclude-file ${exclude_file} && remote-restic forget --keep-daily 7 --keep-monthly 12 --keep-hourly 24 && repo-restic copy --from-repo ${remote} latest && repo-restic forget --keep-hourly 24 --keep-daily 7"];
      StartCalendarInterval = [
        {
          Minute = 0;
        }
      ];
    };
  };
}
