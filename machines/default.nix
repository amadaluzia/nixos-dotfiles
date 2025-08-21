{inputs, ...}: let
  inherit (inputs.self) lib';
in {
  flake = {
    nixosConfigurations = lib'.mkNixosMachines {
      pompeynixos = {
        system = "x86_64-linux";
        extraModules = [
          inputs.hardware.nixosModules.common-gpu-intel
          inputs.hardware.nixosModules.common-gpu-nvidia
          inputs.hardware.nixosModules.common-pc-laptop
          inputs.hardware.nixosModules.common-pc-ssd
        ];
      };
    };
  };
}
