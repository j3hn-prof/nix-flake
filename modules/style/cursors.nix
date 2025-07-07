{
  pkgs,
  lib,
  config,
  user,
  ...
}: {
  options.style.cursors.enable = lib.mkEnableOption "Enable home-manager to control cursor decorations and scaling.";

  config = lib.mkIf config.style.cursors.enable {
    home-manager.users.${user} = {
      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 32;
      };
    };
  };
}
