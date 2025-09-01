{pkgs, ...}: {
  fonts = {
    packages = [
      pkgs.nerd-fonts.monaspace
      pkgs.dm-sans
      pkgs.jost
      pkgs.noto-fonts
    ];
    fontconfig.defaultFonts = {
      monospace = ["MonaspiceKr Nerd Font Mono"];
      sansSerif = ["MonaspiceNeNerd Font"];
      serif = ["MonaspiceXe Nerd Font Mono"];
      emoji = ["Noto Sans Emoji"];
    };
  };
}
