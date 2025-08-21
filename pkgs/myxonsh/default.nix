{runCommand, xonsh, starship, makeWrapper, ...}: let
  myxonsh = xonsh.override {
    extraPackages = ps: builtins.attrValues ps.xonsh.xontribs;
  };
  packages = [
    myxonsh
    starship
  ];
in
  runCommand "xonsh" {
    buildInputs = [ makeWrapper ];
    passthru.shellPath = "/bin/xonsh";
    meta.mainProgram = "xonsh";
  } ''
    mkdir -p $out/bin

    makeWrapper ${myxonsh}/bin/xonsh $out/bin/xonsh \
      --set-default XONSH_CONFIG_DIR ${./config} \
      --prefix PATH ':' ${builtins.concatStringsSep ":" (map (package: "${package}") packages)}
  ''
