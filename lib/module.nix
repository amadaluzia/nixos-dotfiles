{inputs, ...}: {
  flake = {
    lib' = import ./. inputs;
  };
}
