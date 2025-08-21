{
  writeShellApplication,
  alejandra,
  deadnix,
  statix,
}:
writeShellApplication {
  name = "format-and-lint";
  runtimeInputs = [
    alejandra
    deadnix
    statix
  ];
  text = ''
    find . -iname "*.nix" | while read -r file; do
      alejandra "$file"
      deadnix -e "$file"
      statix fix "$file"
    done
  '';
}
