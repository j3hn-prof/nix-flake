{...}:
{
  flake.nixosModules.cli-utils = {pkgs,...}:{
    environment.systemPackages = [
      pkgs.git
      pkgs.yazi
      pkgs.git
      pkgs.tree
      pkgs.btop
      pkgs.wget
      pkgs.fastfetch
    ];
  };
}
