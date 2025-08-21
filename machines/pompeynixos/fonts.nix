{pkgs, ...}: {
  fonts = {
    packages = [
      pkgs.nerd-fonts.caskaydia-cove
      pkgs.dm-sans
      pkgs.jost
      pkgs.noto-fonts
    ];
    fontconfig.defaultFonts = {
      monospace = ["CaskaydiaCove Nerd Font Mono"];
      sansSerif = ["DeepMind Sans"];
      serif = ["Jost*"];
      emoji = ["Noto Sans Emoji"];
    };
  };
}
