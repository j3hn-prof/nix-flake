{self, ...}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    imports = [self.nixosModules.noctalia];
    programs.niri.enable = true;
    # programs.niri.useNautilus = true;
    programs.niri.package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.niri = {
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
    # services.logind.settings.Login.HandlePowerKey = "ignore";
    services.pulseaudio.enable = lib.mkDefault true;
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      brightnessctl
      fuzzel
    ];
  };
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  perSystem = {pkgs, ...}: {
    packages.niri = pkgs.symlinkJoin {
      name = "niri";
      paths = [
        pkgs.niri
        (pkgs.writeScriptBin "wrapper" ''
          ${pkgs.niri}/bin/niri --session --config ${self.lib.getNixtowConfig "niri"}
        '')
      ];
      postBuild = ''
        # Wrap Niri with dotfiles
        mv $out/bin/wrapper $out/bin/niri-session
      '';
    };
  };
}
