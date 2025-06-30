{
  pkgs,
  lib,
  config,
  user,
  dotfiles,
  inputs,
  ...
}: {
  imports = [ inputs.niri.nixosModules.niri ];

  options.desktops.niri.enable = lib.mkEnableOption "Enable the `niri` window manager.";

  config = lib.mkIf config.desktops.niri.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    
    launchers.ulauncher.enable = true;

    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;

    environment = {
      systemPackages = with pkgs; [
      	xwayland-satellite-stable
        adwaita-icon-theme
        nautilus
        vanilla-dmz
      ];
    };
    core.cursors.enable = true;

    services.dbus.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    home-manager.users.${user} = {
      home.file."/.config/niri/config.kdl" = {
        source = "${dotfiles}/niri/config.kdl";
        enable = true;
      };
    };
  };
}
