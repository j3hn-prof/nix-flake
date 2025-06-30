{ config, pkgs, lib, ...}:

{
	options = {

	};

	config = {
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
