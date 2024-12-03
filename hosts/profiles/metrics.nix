{ pkgs, ... }:
{
  services.prometheus = {
    enable = true;
    port = 9001;
    scrapeConfigs = [
      {
        job_name = "dns";
        static_configs = [
          { targets = [ "mole:53" ]; }
        ];
      }
    ];
  };
}
