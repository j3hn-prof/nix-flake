{ config, lib, ... }:
let
  # filterForNix :: AttrSet -> AttrSet
  # Takes an attribute set and removes instances without the `.nix` suffix.
  filterForNix = head:
    lib.filterAttrs (name: _: lib.hasSuffix ".nix" name) head;

  # nixInDir :: String -> List String
  # Takes a directory path and returns a list of file paths (with `.nix` files).
  nixInDir = dir:
    map (file: "/${dir}/${file}")
    (builtins.attrNames ((filterForNix (builtins.readDir dir))));

  # allNixDirs :: List String -> List String
  # Takes a list of directory paths and returns a concatenated list of file paths
  # from all directories (filtered for `.nix` files).
  allNixDirs = dirs: lib.concatMap nixInDir dirs;

in {
  # Uses allNixDirs to gather `.nix` files from each directory in the list;
  imports = allNixDirs [ 
    ./gaming
    ./shells
    ./desktops
    # ./social
    ./browsers
    ./terminals
    ./launchers
    ./widgets
    ./hardware
    ./style
  ];
}

