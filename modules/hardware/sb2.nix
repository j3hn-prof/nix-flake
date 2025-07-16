{
  pkgs,
  lib,
  config,
  inputs,
  user,
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
    '';
    boot.kernelParams = [
      "nosgx"
    ];

    # nixpkgs.config.nvidia.acceptLicense = true;
    # # services.xserver.videoDrivers = [ "nvidia" ];
    # environment.variables = {
    #   GBM_BACKEND = "nvidia-drm";
    #   LIBVA_DRIVER_NAME = "nvidia";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # };
    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true; # Disable if issues with sleep/suspend
        # package = config.boot.kernelPackages.nvidiaPackages.latest;
        nvidiaSettings = true;
        open = false;
      };
      # graphics = {
      #   #driSupport = true;
      #   enable32Bit = true;
      #   extraPackages = with pkgs; [
      #     nvidia-vaapi-driver
      #     vaapiVdpau
      #     libvdpau-va-gl
      #   ];
      # };
    };
    
    environment.systemPackages = with pkgs; [
      surface-control
      # vulkan-loader
      # vulkan-validation-layers
      # vulkan-tools
    ];
    services.udev.packages = with pkgs; [ surface-control];
    users.users.${user}.extraGroups = ["surface-control"]; # surface-control without sudo

    services.thermald.enable = true;
  };
}
