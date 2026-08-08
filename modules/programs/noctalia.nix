{inputs, ...}: {
  flake.nixosModules.noctalia = {
    imports = [inputs.noctalia.nixosModules.default];
    programs.noctalia.enable = true;
    programs.noctalia.recommendedServices.enable = true;
  };
}
