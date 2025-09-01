{pkgs, ...}: {
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    udev.packages = [
      pkgs.android-udev-rules
    ];
    gnome.gnome-keyring.enable = true;
    guix.enable = true;
    openssh.enable = true;
    lvm.enable = true;
    printing.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      extraPackages = [
        pkgs.podman-compose
      ];
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.enable = true;
  };

  programs = {
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-livesplit-one
      ];
    };
    sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraOptions = [
        "--unsupported-gpu"
      ];
      extraPackages = [
        pkgs.brightnessctl
        pkgs.foot
        pkgs.wmenu
        pkgs.swayidle
        pkgs.swaylock
        pkgs.mako
        pkgs.wl-clipboard
      ];
      xwayland.enable = false;
    };
    gnupg.agent.enable = true;
    adb.enable = true;
    waybar.enable = true;
  };

  environment.systemPackages = [
    pkgs.wget
    pkgs.neovim
    pkgs.qemu
  ];
}
