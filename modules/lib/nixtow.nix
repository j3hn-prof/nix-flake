{
  lib,
  config,
  ...
}: let
  cfg = config.nixtow;
in {
  flake.nixosModules.nixtow = {
    options.nixtow = {
      configDir = lib.mkOption {
        type = lib.types.str;
        description = "Path to pull configs from if they exist on the host.";
      };
    };
  };
  flake.lib = {pkgs, ...}: rec {
    getNixtowPath = name: cfg.configDir + "/${name}";

    existsInNixtow = name: builtins.pathExists (getNixtowPath name);

    pullFromNixtow = name:
      if existsInNixtow name
      then getNixtowPath name
      else builtins.throw "File ${name} is not in the specified Nixtow directory ${cfg.configDir}.";

    linkFromNixtow = name: let
      sourceFile = pullFromNixtow name;
    in
      pkgs.runCommand "nixtow-${name}" {} ''
        mkdir -p $out
        ln -s ${sourceFile} $out/${name}
      '';
  };
}
