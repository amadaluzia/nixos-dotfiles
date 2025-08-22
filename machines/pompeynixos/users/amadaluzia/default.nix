{
  inputs,
  system,
  pkgs,
  self,
  ...
}: {
  users.users.amadaluzia = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
    ];
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
        ;
      inherit (pkgs.sway-contrib) grimshot;
      inherit (inputs.nvf.packages.${system}) default;
    };
  };

  systemd.user.tmpfiles.users.amadaluzia.rules = map self.lib'.attrsToTmpfiles [
    {
      type = "L+";
      path = "%h/Pictures/Wallpapers";
      user = "-";
      group = "-";
      age = "-";
      mode = "-";
      arg = ./wallpapers;
    }
    {
      type = "L+";
      path = "%h/.config/alacritty";
      user = "-";
      group = "-";
      age = "-";
      mode = "-";
      arg = ./configs/alacritty;
    }
    {
      type = "L+";
      path = "%h/.config/sway";
      user = "-";
      group = "-";
      age = "-";
      mode = "-";
      arg = ./configs/sway;
    }
    {
      type = "L+";
      path = "%h/.config/waybar";
      user = "-";
      group = "-";
      age = "-";
      mode = "-";
      arg = ./configs/waybar;
    }
  ];
}
