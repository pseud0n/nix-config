# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {
    "com/github/dahenson/agenda" = {
      first-time = false;
      window-position = [ 459 120 ];
      window-size = [ 500 600 ];
    };

    "com/github/maoschanz/drawing" = {
      last-active-tool = "rect_select";
      last-version = "0.8.0";
      maximized = true;
    };

    "com/github/maoschanz/drawing/tools-options" = {
      last-active-shape = "polygon";
      last-delete-replace = "alpha";
      last-font-name = "Sans";
      last-left-rgba = [ "0.0" "0.0" "0.0" "1.0" ];
      last-right-rgba = [ "0.8" "0.0" "0.0" "1.0" ];
      last-shape-filling = "empty";
      last-size = 5;
      last-text-background = "none";
      use-antialiasing = true;
    };

    "org/blueman/general" = {
      window-properties = [ 664 696 0 30 ];
    };

    "org/blueman/plugins/powermanager" = {
      auto-power-on = "@mb false";
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Birmingham', 'EGBB', true, [(0.91542519267102596, -0.030252367883470872)], [(0.91571608669745586, -0.033452149814322159)])>)>]";
    };

    "org/gnome/control-center" = {
      last-panel = "removable-media";
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/alexs/nixos/home-manager/config/sway/backgrounds/bsod-dark.png";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "gb" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      cursor-size = 24;
      cursor-theme = "Breeze_Snow";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "FiraCode Nerd Font Mono,  10";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      toolbar-style = "text";
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "org-gnome-epiphany" ];
    };

    "org/gnome/desktop/notifications/application/org-gnome-epiphany" = {
      application-id = "org.gnome.Epiphany.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      speed = 8.08823529411764e-2;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      lock-delay = "uint32 0";
    };

    "org/gnome/desktop/session" = {
      idle-delay = "uint32 300";
    };

    "org/gnome/desktop/wm/preferences" = {
      action-middle-click-titlebar = "minimize";
      button-layout = "icon:minimize,maximize,close";
      titlebar-font = "FiraCode Nerd Font Medium 11";
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = true;
      window-position = mkTuple [ 0 0 ];
      window-size = mkTuple [ 0 0 ];
    };

    "org/gnome/evince/default" = {
      window-ratio = mkTuple [ 0.7126821793821045 0.7126821793821045 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      maximized = true;
    };

    "org/gnome/nm-applet/eap/1dbafaf2-4af6-4ecd-a057-a4c07447fd3d" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/2407957d-50f3-4bdd-a90c-392e30758732" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/3c37c517-29cc-4ae0-af12-341c162886ef" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/3c5eb65e-2b07-4c0a-a485-65cc7cf4461e" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/4f0f5c9a-bcaf-473b-8e34-56ca09348792" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/9116e93a-fabc-4602-a709-bfaa9227c130" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/bccebaf7-63b9-4761-9eed-0b08f5e51b9a" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/c7218581-f03a-4793-beec-a4ddea4b4d49" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/dd4917ee-24bb-420c-8138-2a524ef36dc8" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/fff249b8-82e6-4400-9a2c-6150fcf0be37" = {
      ignore-ca-cert = true;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/power-manager" = {
      info-history-type = "charge";
      info-last-device = "/org/freedesktop/UPower/devices/battery_BAT0";
      info-page-number = 2;
      info-stats-type = "discharge-accuracy";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = "uint32 3437";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "places-menu@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" ];
      welcome-dialog-last-shown-version = "41.1";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Birmingham', 'EGBB', true, [(0.91542519267102596, -0.030252367883470872)], [(0.91571608669745586, -0.033452149814322159)])>)>]";
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };

    "org/gnome/software" = {
      check-timestamp = "int64 1644492097";
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.8 0.0 ]) (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.8 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 187;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 0 0 ];
      window-size = mkTuple [ 1366 689 ];
    };

  };
}
