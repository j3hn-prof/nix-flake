{
  pkgs,
  lib,
  config,
  user,
  ...
}:
{
  options.editor.helix.enable = lib.mkEnableOption "Enable helix editor and associated configuration.";
  config = lib.mkIf config.editor.helix.enable {
    home-manager.users.${user} = {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
  	      theme = "catppuccin_frappe";
      	};
        extraPackages = with pkgs; [
          jdt-language-server
        ];
      };
    };
  };
}
