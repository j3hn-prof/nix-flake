{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.macbook-pro = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.macbook-pro-config
      self.nixosModules.niri
      self.nixosModules.helix

      self.nixosModules.nixtow
    ];
  };

  flake.nixosModules.macbook-pro-config = {pkgs, ...}: {
    imports = [
      inputs.nixos-apple-silicon.nixosModules.default
      ./_hardware-configuration.nix
    ];

    nix.settings = {
      extra-substituters = [
        "https://nixos-apple-silicon.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };

    hardware.asahi.enable = true;
    hardware.asahi.peripheralFirmwareDirectory = /boot/vendorfw;

    nixtow.configDir = "/home/j3hn/.config/nix/dots";

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = ["quiet" "splash" "loglevel=3"];

    networking.hostName = "macbook-pro"; # Define your hostname.

    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";

    users.users.j3hn = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    };

    environment.systemPackages = [
      pkgs.yazi
      pkgs.git
      pkgs.tree
      pkgs.btop
      pkgs.wget
      pkgs.fastfetch
      pkgs.librewolf
      inputs.ghostty.packages.aarch64-linux.default
    ];

    # Enable Nix Flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    system.stateVersion = "25.11";
  };
}
