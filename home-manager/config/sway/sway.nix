{ config, pkgs, lib, ... }:
with import <nixpkgs> { };
{
	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		config = rec {
			#fonts = {"${defaultFont}" = 15;} ;
			#fonts = { "FiraCode" = 15; };
			floating.criteria = [
				{ "app_id" = "nm-connection-editor"; }
				{ "app_id" = "pavucontrol"; }
			];
			input."*" = {
				xkb_layout = "gb";
				accel_profile = "flat";
				pointer_accel = "-0.5";
			};
			output."*".bg = "${homeConfigDir}/sway/backgrounds/gruvbox-dark-rainbow.png fill";
			terminal = defaultTerminal;
			modifier = "Mod4";
			#menu = "dmenu_path | wofi -i --show run --gtk-dark | xargs swaymsg exec --";
			menu = "fish -c $(echo \"$(fish -c functions)\\n$(dmenu_path)\" | tr -s ', ' '\\n' | wofi -i --show dmenu --gtk-dark)";
			bars = [
				{
					position = "top";
					command = "${pkgs.waybar}/bin/waybar";
				}
			];
			#gaps = {
			#	inner = 0;
			#	outer =  0;
			#};
			window.border = 2;

			keybindings = with config.wayland.windowManager.sway.config; {
				"${modifier}+Return" = "exec $(${homeConfigDir}/sway/scripts/open-terminal-cd.bash 'foot -D')"; # If alacritty, use '${terminal} -e'
				"Ctrl+Mod1+t" = "exec ${terminal}"; # Gnome default
				"${modifier}+d" = "exec ${menu}";
				"${modifier}+w" = "exec epiphany";
				"${modifier}+Shift+q" = "kill";

				"${modifier}+${up}" = "focus up";
				"${modifier}+${down}" = "focus down";
				"${modifier}+${left}" = "focus left";
				"${modifier}+${right}" = "focus right";

				"${modifier}+Up" = "focus up";
				"${modifier}+Down" = "focus down";
				"${modifier}+Left" = "focus left";
				"${modifier}+Right" = "focus right";

				"${modifier}+Shift+${up}" = "move up";
				"${modifier}+Shift+${down}" = "move down";
				"${modifier}+Shift+${left}" = "move left";
				"${modifier}+Shift+${right}" = "move right";

				"${modifier}+Shift+Up" = "move up";
				"${modifier}+Shift+Down" = "move down";
				"${modifier}+Shift+Left" = "move left";
				"${modifier}+Shift+Right" = "move right";

				"${modifier}+b" = "splith";
				"${modifier}+v" = "splitv";

				"${modifier}+1" = "workspace number 1";
				"${modifier}+2" = "workspace number 2";
				"${modifier}+3" = "workspace number 3";
				"${modifier}+4" = "workspace number 4";
				"${modifier}+5" = "workspace number 5";
				"${modifier}+6" = "workspace number 6";
				"${modifier}+7" = "workspace number 7";
				"${modifier}+8" = "workspace number 8";
				"${modifier}+9" = "workspace number 9";
				"${modifier}+0" = "workspace number 10";

				"${modifier}+Shift+1" = "move container to workspace number 1";
				"${modifier}+Shift+2" = "move container to workspace number 2";
				"${modifier}+Shift+3" = "move container to workspace number 3";
				"${modifier}+Shift+4" = "move container to workspace number 4";
				"${modifier}+Shift+5" = "move container to workspace number 5";
				"${modifier}+Shift+6" = "move container to workspace number 6";
				"${modifier}+Shift+7" = "move container to workspace number 7";
				"${modifier}+Shift+8" = "move container to workspace number 8";
				"${modifier}+Shift+9" = "move container to workspace number 9";
				"${modifier}+Shift+0" = "move container to workspace number 10";

				"Ctrl+${modifier}+Left" = "workspace prev";
				"Ctrl+${modifier}+Right" = "workspace next";

				"Ctrl+${modifier}+${left}" = "workspace prev";
				"Ctrl+${modifier}+${right}" = "workspace next";

				"${modifier}+Shift+Space" = "floating toggle";
				"${modifier}+Space" = "focus_mode toggle";
				"${modifier}+f" = "fullscreen toggle";
				#"${modifier}+n" = "exec flashfocus";
				"XF86AudioRaiseVolume" = "exec amixer -q set Master 5%+ unmute && amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print substr($2, 0, length($2)-1) }' > /tmp/wobpipe";
				"XF86AudioLowerVolume" = "exec amixer -q set Master 5%- unmute && amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print substr($2, 0, length($2)-1) }' > /tmp/wobpipe";
				"XF86AudioMute" = "amixer sset Master toggle | sed -En '/\\[on\\]/ s/.*\\[([0-9]+)%\\].*/\\1/ p; /\\[off\\]/ s/.*/0/p' | head -1 > /tmp/wobpipe";
				"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
				"Print" = "exec grim - | wl-copy";
				"${modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
			};

			colors = rec {
				unfocused = {
					text = "#" + gruvboxTheme.red;
					border = "#" + gruvboxTheme.red;
					background = "#" + gruvboxTheme.red;

					indicator = "#" + gruvboxTheme.gray;
					childBorder = "#" + gruvboxTheme.gray;
				};
				focusedInactive = unfocused;
				urgent = unfocused // {
					indicator = "#" + gruvboxTheme.orange;
					childBorder = "#" + gruvboxTheme.orange;
				};
				focused = unfocused // {
					indicator = "#" + gruvboxTheme.yellow;
					childBorder = "#" +  gruvboxTheme.yellow;
				};
			};
		};

		# swaymsg -t get_inputs
		extraConfig = readConfig /sway/config;
	};
}
