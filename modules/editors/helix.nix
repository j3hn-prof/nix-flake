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
          # Java utils
          jdt-language-server
          google-java-format
          # Nix LSP
          nixd
          # QML LSP
          qt6.qtdeclarative
        ];
      };
    };
  };
}
