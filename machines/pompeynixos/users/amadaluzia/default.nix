{
  inputs,
  system,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./swaybg.nix
    ./tmpfiles.nix
  ];

  users.users.amadaluzia = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "adbusers"
      "podman"
    ];
    shell = self.packages.${system}.myxonsh;
    packages = builtins.attrValues {
      inherit
        (pkgs)
        chromium
        alacritty
        eza
        aerc
        irssi
        nh
        mpv
        tree
        neovide
        git
        fuzzel
        pavucontrol
        vesktop
        rmg-wayland
        ripgrep
        bat
        android-studio
        ;
      inherit (pkgs.sway-contrib) grimshot;
      inherit (inputs.nvf.packages.${system}) default;
    };
  };
}
