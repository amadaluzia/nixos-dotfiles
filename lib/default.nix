inputs: let
  inherit (inputs.nixpkgs.lib.attrsets) filterAttrs;
  inherit (inputs.nixpkgs.lib.generators) toINI mkKeyValueDefault mkValueStringDefault;
  mkNixosMachine = {
    system,
    hostname,
    extraModules ? [],
    extraSpecialArgs ? {},
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          "${inputs.self}/machines/${hostname}"
          "${inputs.self}/modules/nixos"
        ]
        ++ extraModules;
      specialArgs =
        {
          inherit inputs system;
          inherit (inputs) self;
          inherit (inputs.self) lib';
        }
        // extraSpecialArgs;
    };
  mkNixosMachines = machines:
    builtins.mapAttrs (
      hostname: conf:
        mkNixosMachine (
          {
            inherit hostname;
          }
          // conf
        )
    )
    machines;
  listFilesRecursive = dir:
    filterAttrs (_: v: v != {}) (builtins.mapAttrs (
      path: type:
        if type == "directory"
        then listFilesRecursive /${dir}/${path}
        else /${dir}/${path}
    ) (builtins.readDir dir));
  attrsToTmpfiles = {
    type,
    path,
    mode,
    user,
    group,
    age,
    arg ? null,
  }:
    builtins.concatStringsSep " " (builtins.filter (c: c != null) [
      type
      path
      mode
      user
      group
      age
      arg
    ]);
  mkDconfUser = pkgs: source:
    pkgs.runCommand "dconf-user" {
      buildInputs = [
        pkgs.dconf
      ];
    } ''
      mkdir src
      cp ${source} src
      dconf compile $out src
    '';
  toSystemdUnit = toINI {
    mkKeyValue = mkKeyValueDefault {
      mkValueString = v:
        if builtins.isList v
        then builtins.concatStringsSep " " v
        else mkValueStringDefault {} v;
    } "=";
  };
  mkSystemdUnit = pkgs: name: attrs:
    pkgs.writeTextFile {
      inherit name;
      text = toSystemdUnit attrs;
    };
in {
  inherit mkNixosMachines listFilesRecursive attrsToTmpfiles mkDconfUser mkSystemdUnit;
}
