{
  lib,
  config,
  user,
  ...
}: {
  options.terminals.ghostty.enable = lib.mkEnableOption "Enable the `ghostty` terminal emulator.";
  options.terminals.ghostty.font-size = lib.mkOption {
    type = lib.types.int;
    description = "Sets font size for `ghotty`. Defaults to 12";
  };

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
