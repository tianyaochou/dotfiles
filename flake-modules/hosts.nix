{
  inputs,
  self,
  ...
}: let
  hosts = inputs.haumea.lib.load {
    src = ../hosts;
    inputs = {
      flake = self;
      deploy = inputs.deploy-rs;
    };
  };
in {
  flake.hosts = hosts;
}
