{
  pkgs,
  lib,
  config,
  ...
}:
let
  sb2 = "hardware.microsoft-surface.surface-book-2";
in
{
  options.hardware.microsoft-surface.surface-book-2 = lib.mkEnableOption
    "Enable configuration for Surface Book 2";

  config = lib.mkIf config.hardware.microsoft-surface.surface-book-2 {
    hardware.microsoft-surface = {
      kernelVersion = "stable";
    };
    boot.extraModprobeConfig = ''
      softdep soc_button_array pre: pinctrl_sunrisepoint
    '';
    boot.kernelParams = [
      "nosgx"
    ];

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;

    environment.systemPackages = with pkgs; [ surface-control ];
    services.udev.packages = with pkgs; [ surface-control];
    users.groups.surface-control = { };

    services.thermald.enable = true;
  };
}
