{
  description = "j3hn's personal Nix flake";

  inputs = {
    # Stable pin for Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    # Unsable pin of Apple Silicon NixOS Module for modern support
    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    # Dendritic Pattern Utils
    # Flake-Parts for modularization
    flake-parts.url = "github:hercules-ci/flake-parts";
    # Recursive import tree helper
    import-tree.url = "github:denful/import-tree";

    # Application specific flakes
    # Ghostty upstream (FIX: vertical flickering bars)
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs @ {...}: let
    inherit (inputs) import-tree flake-parts;
    mkFlake = flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake (import-tree ./modules);
}
