{
  lib',
  pkgs,
  ...
}:
lib'.mkDconfUser pkgs {
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "Nordic-bluish-accent-standard-buttons";
    icon-theme = "Nordzy-purple-dark";
    cursor-theme = "Nordzy-cursors";
  };
}
