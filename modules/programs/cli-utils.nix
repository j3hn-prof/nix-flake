{ self, ... }: {
  flake.nixosModules.cli-utils = {pkgs, ...}: {
    imports = [ self.nixosModules.fish ];
    environment.systemPackages = [
      pkgs.jq
      # pkgs.yazi
      pkgs.tree
      pkgs.btop
      pkgs.wget
      pkgs.fastfetch
      pkgs.fd
      pkgs.bat
    ];

    # Git setup
    programs.git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user = {
          name = "j3hn";
          email = "johnrossi2601@gmail.com";
        };
      };
    };
  };

  flake.nixosModules.fish = {pkgs, ...}: {
    users.defaultUserShell = pkgs.fish;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        source $(${pkgs.writeScriptBin "script" ''
          echo ${self.lib.getNixtowConfig "fish"}
        ''}/bin/script)
      '';
    };
    environment.systemPackages = [
      # trying to use tv to replace all fuzzy finders
      pkgs.television
    ];
  };
}
