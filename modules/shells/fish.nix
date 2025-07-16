{
  pkgs,
  lib,
  config,
  user,
  ...
}: {
  options = {
    shells.fish.enable = lib.mkEnableOption "Enables `fish` as default shell for user.";
  };

  config = lib.mkIf config.shells.fish.enable {
    users.users.${user} = {
      shell = pkgs.fish;
      packages = [ pkgs.fish ];
    };
    home-manager.users.${user} = {
      xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
      home.packages = [pkgs.grc];
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          set --universal pure_enable_single_line_prompt true # Smaller prompt
          set --universal pure_enable_nixdevshell true # Indication of nix shell
          set --universal pure_symbol_prompt "\n❯" # Add newline before prompt
          set --universal pure_symbol_nixdevshell_prefix "❄️ " # Adds space after nix develop icon
        '';
        plugins = [
          # Enable a plugin (here grc for colorized command output) from nixpkgs
          { name = "pure"; src = pkgs.fishPlugins.pure.src; }
          { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        ];
      };
    };
  };
}
