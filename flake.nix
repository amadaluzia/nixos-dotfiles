{
  outputs = inputs @ {parts, ...}:
    parts.lib.mkFlake {inherit inputs;} (_top: {
      imports = [
        ./lib/module.nix
        ./machines
      ];
      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.callPackage ./shell {};
        formatter = pkgs.callPackage ./formatter.nix {};
        packages = builtins.foldl' (acc: it: acc // it) {} (map (dir: {
          ${dir} = pkgs.callPackage ./pkgs/${dir} {inherit inputs;};
        }) (builtins.attrNames (builtins.readDir ./pkgs)));
      };
      systems = [
        "x86_64-linux"
      ];
    });

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hardware = {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
    };
    nvf = {
      type = "git";
      url = "file:///home/amadaluzia/.config/nvf";
    };
  };
}
