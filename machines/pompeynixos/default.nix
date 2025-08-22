{config, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./users/amadaluzia
    ./fonts.nix
    ./software.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = {
      pompey_nvme = {
        device = "/dev/disk/by-uuid/702f8c95-7265-4b00-bd9e-69797e73787c";
      };
    };
  };

  hardware.nvidia = {
    open = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  networking = {
    hostName = "pompey_nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    # useXkbConfig = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.05";
}
