{ pkgs, ... }:
{
  services.prometheus = {
    enable = true;
    port = 9001;
    scrapeConfigs = [
      {
        job_name = "dns";
        static_configs = [
          { targets = [ "mole:4000" ]; }
        ];
      }
      {
        job_name = "node";
        static_configs = [
          { targets = [ "mole:9002" "mainframe:9002" "gateway:9002" "kaelder:9002" ]; }
        ];
      }
    ];
  };
}
