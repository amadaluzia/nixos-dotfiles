{
  mkShell,
  alejandra,
  deadnix,
  statix,
}:
mkShell {
  packages = [
    alejandra
    deadnix
    statix
  ];
}
