{
  runCommand,
  lib,
  xonsh,
  starship,
  zoxide,
  makeWrapper,
  ...
}: let
  myxonsh = xonsh.override {
    extraPackages = ps: [
      ps.xonsh.xontribs.xonsh-direnv
      ps.xonsh.xontribs.xontrib-abbrevs
      ps.xonsh.xontribs.xontrib-fish-completer
      ps.xonsh.xontribs.xontrib-vox
    ];
  };
  paths = [
    myxonsh
    starship
    zoxide
  ];
in
  runCommand "xonsh" {
    buildInputs = [makeWrapper];
    passthru.shellPath = "/bin/xonsh";
    meta.mainProgram = "xonsh";
  } ''
    mkdir -p $out/bin

    makeWrapper ${myxonsh}/bin/xonsh $out/bin/xonsh \
      --set-default XONSH_CONFIG_DIR ${./config} \
      --prefix PATH ':' ${lib.makeBinPath paths}
  ''
