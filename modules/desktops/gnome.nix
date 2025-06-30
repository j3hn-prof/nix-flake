{
  pkgs,
  lib,
  config,
  user,
  ...
}: {
  options = {
    desktops.gnome.enable = lib.mkEnableOption "Enable GNOME and GDM to work as the desktop.";
  };

  config = lib.mkIf config.desktops.gnome.enable {
    services.displayManager.gdm.enable = true; # Gnome Display Manager
    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = (with pkgs; [
      atomix # puzzle game
      # cheese # webcam tool
      epiphany # web browser
      # evince # document viewer
      geary # email reader
      gedit # text editor
      # gnome-characters
      gnome-music
      gnome-photos
      # gnome-terminal
      gnome-tour
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
    ]);

    # Workaround to prevent TTY switching during GNOME autologin
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
    home-manager.users.${user} = {
      home.packages = with pkgs.gnomeExtensions; [
        appindicator
        space-bar
        disable-workspace-switcher-overlay
        forge
      ];

      # ============= dconf backup (manually edited) =================
      dconf.settings = with lib.hm.gvariant; {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com" # Adds tray icons like on KDE
            "space-bar@luchrioh" # Shows workspaces on the panel
            "disable-workspace-switcher-overlay@cleardevice" # Disables workspace switcher overlay
            "forge@jmmaranan.com" # Tiler
          ];
          favorite-apps = [ "firefox.desktop" "vesktop.desktop" ];
          last-selected-power-profile = "performance";
        };

        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
          picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          two-finger-scrolling-enabled = true;
        };

        "org/gnome/desktop/session" = {
          idle-delay = mkUint32 900;
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 5;
          workspace-names = [];
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Shift><Super>q" ];
          move-to-workspace-1=["<Super><Shift>1"];
          move-to-workspace-2=["<Super><Shift>2"];
          move-to-workspace-3=["<Super><Shift>3"];
          move-to-workspace-4=["<Super><Shift>4"];
          move-to-workspace-5=["<Super><Shift>5"];
          move-to-workspace-6=["<Super><Shift>6"];
          move-to-workspace-7=["<Super><Shift>7"];
          move-to-workspace-8=["<Super><Shift>8"];
          move-to-workspace-9=["<Super><Shift>9"];
          move-to-workspace-10=["<Super><Shift>0"];
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          switch-to-workspace-6 = ["<Super>6"];
          switch-to-workspace-7 = ["<Super>7"];
          switch-to-workspace-8 = ["<Super>8"];
          switch-to-workspace-9 = ["<Super>9"];
          switch-to-workspace-10 = ["<Super>0"];
          panel-run-dialog = [];
        };

        "org/gnome/shell/keybindings" = {
          focus-active-notification = [];
        };

        "org/gnome/shell/extensions/space-bar/shortcuts" = {
          activate-empty-key = [ "<Super>n" ];
          back-and-forth = false;
          enable-activate-workspace-shortcuts = true;
          enable-move-to-workspace-shortcuts = true;
          open-menu = [];
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = false;
          workspaces-only-on-primary = false;
        };

        "org/gnome/mutter/wayland/keybindings" = {
          restore-shortcuts = [];
        };

        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "interactive";
          sleep-inactive-ac-timeout = 7200;
          sleep-inactive-ac-type = "suspend";
        };

        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
        };

        "org/gnome/shell/extensions/status-area-horizontal-spacing" = {
          hpadding = 5;
        };

        "org/gnome/shell/extensions/trayIconsReloaded" = {
          icon-brightness = -20;
          icon-margin-horizontal = 5;
          icon-margin-vertical = 0;
          icon-padding-horizontal = 5;
          icon-padding-vertical = 5;
          icon-size = 20;
          tray-margin-left = 0;
          tray-position = "right";
        };

        "org/gnome/shell/extensions/space-bar/appearance" = {
          active-workspace-font-size = 11;
          active-workspace-font-size-active = true;
          active-workspace-font-size-user = 11;
          active-workspace-font-weight = "800";
          application-styles = ".space-bar {n  -natural-hpadding: 10px;n}nn.space-bar-workspace-label.active {n  margin: 0 2px;n  background-color: rgba(255,255,255,0.3);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 800;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n  font-size: 11pt;n}nn.space-bar-workspace-label.inactive {n  margin: 0 2px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 800;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n  font-size: 11pt;n}nn.space-bar-workspace-label.inactive.empty {n  margin: 0 2px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,0.5);n  border-color: rgba(0,0,0,0);n  font-weight: 800;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n  font-size: 11pt;n}";
          empty-workspace-font-size = 11;
          empty-workspace-font-weight = "800";
          inactive-workspace-font-size = 11;
          inactive-workspace-font-weight = "800";
          workspace-margin = 2;
          workspaces-bar-padding = 10;
        };

        "org/gnome/shell/extensions/space-bar/behavior" = {
          always-show-numbers = false;
          indicator-style = "workspaces-bar";
          show-empty-workspaces = false;
          system-workspace-indicator = false;
          toggle-overview = false;
        };

        "org/gnome/shell/extensions/space-bar/state" = {
          version = 33;
        };
      };
    };
  };
}
