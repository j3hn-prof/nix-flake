{self, system, ...}: {
  flake.nixosModules.helix = {
    environment = {
      systemPackages = [self.packages.${system}.helix];
      sessionVariables = {
        EDITOR = "hx";
      };
    };
  };

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
  perSystem = {pkgs, ...}: {
    packages.helix = pkgs.symlinkJoin {
      name = "hx";
      paths = [
        (pkgs.writeScriptBin "wrapper" ''
          ${pkgs.helix}/bin/hx -c ${self.lib.getNixtowConfig "helix"} "$@"
        '')
        pkgs.helix

        # Language Servers and Formaters
        pkgs.nil
        pkgs.nixfmt
      ];
      postBuild = ''
        mv $out/bin/wrapper $out/bin/hx
      '';
    };
  };
}
