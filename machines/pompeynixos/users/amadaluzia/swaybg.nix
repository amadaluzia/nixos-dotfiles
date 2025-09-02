{
  lib',
  pkgs,
  ...
}: {
  systemd.user.tmpfiles.users.amadaluzia.rules = [
    (lib'.attrsToTmpfiles {
      type = "L+";
      path = "%h/.config/systemd/user/swaybg.service";
      user = "-";
      group = "users";
      age = "-";
      mode = "644";
      arg = lib'.mkSystemdUnit pkgs "swaybg.service" {
        Unit = {
          Description = "swaybg - wallpaper daemon";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session-pre.target"];
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/Wallpapers/ign_batman.png";
        };
      };
    })
  ];
}
