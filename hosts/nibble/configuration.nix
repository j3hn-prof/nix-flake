{
  inputs,
  pkgs,
  lib,
  host,
  user,
  dotfiles,
  modules,
  system,
  stateVersion,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${modules}" # Custom application module collection
    "${modules}/hardware/sb2.nix" # Module for Surface Book 2 (nixos-hardware)
  ];

  # desktops.gnome.enable = true;
  desktops.niri = {
    enable = true;
    darkmode = true;
  };

  shells.fish.enable = true;

  # social.discord.enable = true;

  terminals.ghostty.enable = true;
  editor.helix.enable = true;

  hardware.microsoft-surface.surface-book-2 = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  time.timeZone = "America/New_York";

  # Set default locale and additional locale environment variables
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = builtins.listToAttrs (map (lc: {
      name = lc; value = "en_US.UTF-8";
    }) [
      "LC_ADDRESS" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MONETARY"
      "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME"
    ]);
  };

  # Enable CUPS printing service
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    description = "John Rossi";
    extraGroups = [ "networkmanager" "wheel" "surface-control" ]; # Network and sudo privileges
    ignoreShellProgramCheck = true;
  };

  # Configure sudo to extend authentication timeout to 1 hour
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults timestamp_timeout=60
    '';
  };

  # List of packages installed system-wide
  environment.systemPackages = with pkgs; [
    libcamera

    neovim
    btop
    git
    fastfetch
    tree
    nixfmt-rfc-style
    yazi
    vesktop
  ];
  
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.adwaita-mono
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
    cantarell-fonts
    inter
  ];

  # Set the initial system state version (required for upgrades)
  system.stateVersion = stateVersion;

  # Enable experimental Nix features: flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
