{ inputs, ... }:
{
  flake.lib = let module-transformer = cursor: map: {}; in {
    load-module = inputs.haumea.lib.load;
  };
}
