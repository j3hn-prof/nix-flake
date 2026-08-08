{self, ...}: {
  flake.nixosModules.nixtow = {
    config,
    lib,
    ...
  }: {
    options.nixtow = {
      configDir = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Global path to dotfiles directory";
      };
      # included
    };

    config = {
      environment.etc."nixtow/config".text = let
        nixtowPath = config.nixtow.configDir;
      in ''
        base=${nixtowPath}
        helix=${nixtowPath}/helix/config.toml
        niri=${nixtowPath}/niri/config.kdl
        fish=${nixtowPath}/fish/config.fish
      '';
    };
  };

  flake.lib = {
    getNixtowConfig = key: ''$(if [ -e /etc/nixtow/config ]; then val=$(awk -F= '$1 == "${key}" {print $2}' /etc/nixtow/config); if [ -e $val ]; then echo $val; else echo "${self}/dots/${key}/config.toml"; fi else "${self}/dots/${key}/config.toml"; fi)'';
  };
}
