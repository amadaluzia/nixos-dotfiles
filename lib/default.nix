inputs: let
  inherit (inputs.nixpkgs.lib.attrsets) filterAttrs;
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
        }
        // extraSpecialArgs;
    };
  mkNixosMachines = machines:
    __mapAttrs (
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
    filterAttrs (_: v: v != {}) (__mapAttrs (
      path: type:
        if type == "directory"
        then listFilesRecursive /${dir}/${path}
        else /${dir}/${path}
    ) (__readDir dir));
  attrsToTmpfiles = {
    type,
    path,
    mode,
    user,
    group,
    age,
    arg ? null,
  }:
    __concatStringsSep " " (__filter (c: c != null) [
      type
      path
      mode
      user
      group
      age
      arg
    ]);
in {
  inherit mkNixosMachines listFilesRecursive attrsToTmpfiles;
}
