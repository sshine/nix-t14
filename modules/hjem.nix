{ inputs, ... }:
{
  flake.nixosModules.hjem =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.hjem.nixosModules.default ];

      hjem.users.sshine = {
        enable = true;
        user = "sshine";
        directory = "/home/sshine";

        files.".config/kitty/kitty.conf".text = ''
          font_family Meslo
          font_size 14
        '';

        files.".config/fuzzel/fuzzel.ini".text = lib.generators.toINI { } {
          main = {
            terminal = "kitty";
            font = "Meslo:size=20";
            anchor = "center";
            horizontal-pad = 10;
            vertical-pad = 10;
          };
          colors = {
            background = "1b1d1edd";
            text = "6e6e6eff";
            match = "1b1d1e80";
            selection = "4d4f4c80";
            selection-text = "505354ff";
            border = "1b1d1eff";
          };
          border = {
            width = 1;
            radius = 5;
          };
        };

        files.".config/waybar/config".text = builtins.toJSON {
          position = "bottom";
          layer = "top";
          height = 5;
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "tray"
            "cpu"
            "memory"
            "disk"
            "pulseaudio"
            "battery"
            "network"
            "custom/notification"
          ];
          clock = {
            calendar = {
              format = {
                today = "<span color='#b4befe'><b><u>{}</u></b></span>";
              };
            };
            format = " {:%H:%M}";
            tooltip = "true";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = " {:%d/%m}";
          };
          "hyprland/workspaces" = {
            active-only = false;
            disable-scroll = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              "1" = "󰈹";
              "2" = "";
              "3" = "󰘙";
              "4" = "󰙯";
              "5" = "";
              "6" = "";
              urgent = "";
              default = "";
              sort-by-number = true;
            };
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
            };
          };
          memory = {
            format = "󰟜 {}%";
            format-alt = "󰟜 {used} GiB";
            interval = 2;
          };
          cpu = {
            format = "  {usage}%";
            format-alt = "  {avg_frequency} GHz";
            interval = 2;
          };
          disk = {
            format = "󰋊 {percentage_used}%";
            interval = 60;
          };
          network = {
            format-wifi = "  {signalStrength}%";
            format-ethernet = "󰀂 ";
            tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "󰖪 ";
          };
          tray = {
            icon-size = 20;
            spacing = 8;
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "  {volume}%";
            format-icons = {
              default = [ " " ];
            };
            scroll-step = 5;
            on-click = "pamixer -t";
          };
          battery = {
            format = "{icon} {capacity}%";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
            format-charging = " {capacity}%";
            format-full = " {capacity}%";
            format-warning = " {capacity}%";
            interval = 5;
            states = {
              warning = 20;
            };
            format-time = "{H}h{M}m";
            tooltip = true;
            tooltip-format = "{time}";
          };
          "custom/launcher" = {
            format = "";
            on-click = "fuzzel";
            tooltip = "false";
          };
        };

        files.".config/gtk-3.0/settings.ini".text = lib.generators.toINI { } {
          Settings = {
            gtk-cursor-theme-name = "Bibata-Modern-Classic";
            gtk-cursor-theme-size = 16;
            gtk-theme-name = "Flat-Remix-GTK-Grey-Darkest";
            gtk-icon-theme-name = "Adwaita";
            gtk-font-name = "Sans 11";
          };
        };

        files.".icons/default/index.theme".text = ''
          [Icon Theme]
          Inherits=Bibata-Modern-Classic
        '';

        packages = with pkgs; [
          bibata-cursors
          flat-remix-gtk
          adwaita-icon-theme
        ];
      };
    };
}
