{ inputs, ... }:
let
  transformer = cursor: set: if set ? default then set.default else set;
  haumea = inputs.haumea.lib;
in
{
  flake = {
    home = haumea.load {
      src = ../home-manager;
      transformer = transformer;
      loader = haumea.loaders.verbatim;
    };
  };
}
