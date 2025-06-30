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

  home.sessionVariables = { # BROKEN !!!
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
