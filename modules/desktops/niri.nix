{
  pkgs,
  lib,
  config,
  user,
  dotfiles,
  inputs,
  system,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  imports = [ inputs.niri.nixosModules.niri ];

  options.desktops.niri.enable = mkEnableOption "Enable the `niri` window manager.";
  options.desktops.niri.darkmode = mkEnableOption "Enable darkmode for this desktop";

  config = mkIf config.desktops.niri.enable {
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
    style.cursors.enable = true;
    style.darkmode = config.desktops.niri.darkmode;

    services.dbus.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    home-manager.users.${user} = {
      home.file."/.config/niri/config.kdl" = {
        source = "${dotfiles}/niri/config.kdl";
        enable = true;
      };

      home.packages = with pkgs; [
        papers
        gnome-secrets
        inputs.quickshell.packages.${system}.default
      ];
    };
  };
}
