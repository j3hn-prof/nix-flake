{
  pkgs,
  lib,
  osConfig,
  user,
  stateVersion,
  ...
}: {
  
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.stateVersion = stateVersion; 

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  programs.home-manager.enable = true;
}
