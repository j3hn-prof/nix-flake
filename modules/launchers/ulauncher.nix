{
  pkgs,
  lib,
  config,
  user,
  dotfiles,
  inputs,
  ...
}: {
  options.launchers.ulauncher.enable = lib.mkEnableOption "Enable the `ulauncher` app launcher.";

  config = lib.mkIf config.launchers.ulauncher.enable {
    nixpkgs.overlays = [ inputs.ulauncher.overlays.default ];
    home-manager.users.${user} = {
      home.packages = [ pkgs.ulauncher6 ];
      home.file."/.config/ulauncher/" = {
        source = "${dotfiles}/ulauncher/";
        recursive = true;
        enable = true;
      };
    };
  };
}
