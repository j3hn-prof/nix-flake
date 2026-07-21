{...}:
{
  flake.nixosModules.docker = {
    virtualisation.docker.enable = true;
    users.users.j3hn.extraGroups = [ "docker" ];
  };
}
