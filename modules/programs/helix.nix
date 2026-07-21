{self, ...}: {
  flake.nixosModules.helix = {
    environment = {
      systemPackages = [ self.packages.aarch64-linux.helix ];
      sessionVariables = {
        EDITOR = "hx";
      };
    };
  };
  
  systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.helix =
      pkgs.symlinkJoin {
        name = "hx";
        paths = [
          pkgs.helix
        ];
        buildInputs = [
           pkgs.makeWrapper
        ];
        postBuild = ''
          wrapProgram $out/bin/hx --add-flags "-c" --add-flags "${self.lib.sdslinkFromNixtow "helix/config.toml"}";
        '';
      };
  };
}
