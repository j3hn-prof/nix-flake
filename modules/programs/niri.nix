{...}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri.enable = true;
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    };
    services.pulseaudio.enable = lib.mkDefault true;
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      brightnessctl
      fuzzel
    ];
  };
}
