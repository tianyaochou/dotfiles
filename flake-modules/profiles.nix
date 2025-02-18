{ inputs, lib, ... }:
{
  flake.profiles = let
    transformer = cursor: set: if set ? default then set.default else set;
  in
  inputs.haumea.lib.load { src = ../profiles; transformer = transformer; loader = inputs.haumea.lib.loaders.verbatim; };
}
