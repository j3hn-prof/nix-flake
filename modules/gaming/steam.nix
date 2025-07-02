{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gaming.steam.enable = lib.mkEnableOption "Enable the `Steam` store-front, launcher, and related utilities. This includes protonup/tricks";

  config = lib.mkIf config.gaming.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };

    environment = {
      systemPackages = with pkgs; [
        mangohud
        protontricks
        protonup
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };

    programs.gamemode.enable = true;
  };
}
