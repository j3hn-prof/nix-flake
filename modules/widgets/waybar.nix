{
  lib,
  config,
  user,
  dotfiles,
  ...
}: {
  options.widgets.waybar.enable = lib.mkEnableOption "Enables the `waybar` statusbar.";
  config = lib.mkIf config.widgets.waybar.enable {
    home-manager.users.${user} = {
      programs.waybar = {
        enable = true;
        settings.mainBar.include = [ "${dotfiles}/waybar/waybar-config" ];
        style = builtins.readFile "${dotfiles}/waybar/waybar-css.css";
      };
    };
  };
}
