{
  lib',
  pkgs,
  ...
}: {
  systemd.user.tmpfiles.users.amadaluzia.rules = map lib'.attrsToTmpfiles [
    {
      type = "L+";
      path = "%h/Pictures/Wallpapers";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = ./wallpapers;
    }
    {
      type = "L+";
      path = "%h/.config/alacritty";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = ./configs/alacritty;
    }
    {
      type = "L+";
      path = "%h/.config/niri";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = ./configs/niri;
    }
    {
      type = "L+";
      path = "%h/.config/waybar";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = ./configs/waybar;
    }
    {
      type = "L+";
      path = "%h/.config/dconf/user";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = import ./dconf.nix;
    }
    {
      type = "L+";
      path = "%h/.themes/Nordic-bluish-accent-standard-buttons";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = "${pkgs.nordic}/share/themes/Nordic-bluish-accent-standard-buttons";
    }
    {
      type = "L+";
      path = "%h/.icons/Nordzy-cursors";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = "${pkgs.nordzy-cursor-theme}/share/icons/Nordzy-cursors";
    }
    {
      type = "L+";
      path = "%h/.icons/Nordzy-purple-dark";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = "${pkgs.nordzy-icon-theme}/share/icons/Nordzy-purple-dark";
    }
  ];
}
