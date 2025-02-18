{ inputs, config, ... }:
{
  flake = {
    users = inputs.haumea.lib.load { src = ../users; inputs = { home = config.flake.home; }; };
  };
}
