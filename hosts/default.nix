{
  lib,
  nixpkgs,
  home-manager,
  inputs,
  hosts,
  dotfiles,
  modules,
  ...
}:

let
  mkNixosSystem = { host, user ? "j3hn", system, stateVersion }: 
    let
      specialArgs = {
        inherit inputs host user dotfiles modules system stateVersion;
      };
    in nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = specialArgs;
        modules = [
          ./${host}/configuration.nix
          {
          nixpkgs.config = {
            allowUnfree = true;
            allowBroken = true;
            allowUnsupportedSystem = true;
          };
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.${user} = {
              imports = [ ./${host}/home.nix ];
            };
          }
        ];
      };
in
builtins.listToAttrs (
  map (h: {
    name = h.host;
    value = mkNixosSystem { inherit (h) host system stateVersion; };
  }) hosts
)
