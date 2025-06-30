{
  description = "j3hn's Nix Flake ❄️";

  inputs = {
    # Input reference to nixpkgs (Nix Packages collection)
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Input reference to home-manger (Nix Tooling for User Configurations)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Input reference to a flake for `niri` (Scrolling Window Manager)
    niri.url = "github:sodiboo/niri-flake";

    # Input reference to the upstream flake for `ulauncher` (GTK 3 applicaiton launcher)
    ulauncher.url = "github:j3hn-prof/Ulauncher";
    ulauncher.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
  let
    hosts =[
      {
        # "Laptop" (Shitty Work One)
        host = "nibble";
        system = "x86_64-linux";
        stateVersion = "25.11";
      }
      {
        # Desktop PC (RX 6700xt)
        host = "sparky";
        system = "x86_64-linux";
        stateVersion = "25.05";
      }
    ];

    dotfiles = ./dotfiles;
    modules = ./modules;

    commonInherits = {
      inherit (nixpkgs) lib;
      inherit nixpkgs home-manager inputs;
      inherit hosts dotfiles modules;
    };
  in {
    # Look for hosts in ./hosts
    nixosConfigurations = import ./hosts commonInherits;
  };
}

