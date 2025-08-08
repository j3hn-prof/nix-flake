{
  lib,
  config,
  user,
  ...
}: {
  options.terminals.ghostty.enable = lib.mkEnableOption "Enable the `ghostty` terminal emulator.";

  config = lib.mkIf config.terminals.ghostty.enable {
    home-manager.users.${user} = {
      programs.ghostty = {
        enable = true;
      	settings = {
          font-size = 13;
          window-padding-color= "extend";
          theme = "Monokai Pro Spectrum";
          window-decoration = "false";
          window-padding-y = 0;
          window-padding-x = 2;
          window-padding-balance = true;
       	};
      };
    };
  };
}
