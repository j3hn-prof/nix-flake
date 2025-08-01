{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  sb2 = "hardware.microsoft-surface.surface-book-2";
in
{
  imports = [ inputs.nixos-hardware.nixosModules.microsoft-surface-common ];
  options.hardware.microsoft-surface.surface-book-2 = lib.mkEnableOption
    "Enable configuration for Surface Book 2";

  config = lib.mkIf config.hardware.microsoft-surface.surface-book-2 {
    hardware.microsoft-surface = {
      kernelVersion = "stable";
    };
    boot.extraModprobeConfig = ''
      softdep soc_button_array pre: pinctrl_sunrisepoint
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
    boot.kernelParams = [
      "nosgx"
    ];

    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    boot.kernelModules = [ "v4l2loopback" ];  

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;

    environment.systemPackages = with pkgs; [
      surface-control
      libcamera
      linux-firmware
    ];
    services.udev.packages = with pkgs; [ surface-control];
    users.groups.surface-control = { };

    services.thermald.enable = true;
  };
}
