{
  pkgs,
  lib,
  config,
  ...
}: {
  options.gaming.minecraft.enable = lib.mkEnableOption "Enable Prism Launcher to play Minecraft.";
  config = lib.mkIf config.gaming.minecraft.enable {
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ ffmpeg ];

        # Change Java runtimes available to Prism Launcher
        jdks = [
          graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
      graalvm-ce
      zulu8
      zulu17
      zulu
    ];
    networking.firewall.allowedTCPPorts = [ 25565 ];
    networking.firewall.allowedUDPPorts = [ 25565 ];
  };
}
