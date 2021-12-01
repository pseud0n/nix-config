{ config, pkgs, lib, ... }:
with import <nixpkgs> { config = { allowUnfree = true; }; };

let
	nixosConfig = (import <nixpkgs/nixos> {}).config;

	homeConfigDir = /etc/nixos/home-manager/config;

#	unstableTarball = fetchTarball
#      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;

	gruvboxTheme = {
		bg = "32302f";
		fg = "ebdbb2";
		red = "fb4934"; #"cc241d";
		green = "98971a";
		yellow = "d79921";
		blue = "458588";
		purple = "b16286";
		aqua = "689d6a";
		orange = "fe8019";
		gray = "a89984";
	};

	defaultFont = "Fira Code";
	pangoFont = n: "${defaultFont} ${builtins.toString n}";
	defaultBackground = gruvboxTheme.bg;
	addAlpha = hex: "${defaultBackground}${hex}";
	defaultBackgroundAlpha = addAlpha "FF";
	#defaultTerminal = nixosConfig.environment.variables.TERMINAL; #"${config.environment.variables.TERMINAL}";
	defaultTerminal = nixosConfig.environment.variables.TERMINAL;
	devDir = nixosConfig.environment.variables.DEV_DIR;

	readConfig = path: builtins.readFile (homeConfigDir + path);
	
	isPi = builtins.currentSystem == "aarch64-linux";
	
	jetbrainsOverride = import ./jetbrains/default.nix {
		inherit lib stdenv callPackage fetchurl
		cmake zlib python3
		dotnet-sdk_5
		autoPatchelfHook
		libdbusmenu;
		jdk = jdk11;
	};

in rec {
#	nixpkgs.config.packageOverrides = pkgs: {
#		nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
#			inherit pkgs;
#		};
#		unstable = import unstableTarball {
#			config = config.nixpkgs.config;
#		};
#    };
	
	nixpkgs.config.allowUnfree = true;
	#nixpkgs.config.allowBroken = false;
	#allowBrokenPredicate = pkg: builtins.elem (lib.getName pkg) [
	#	"ghc-vis"
	#];
	nixpkgs.config.
	programs.home-manager.enable = true;

	home.username = "alexs";
	home.homeDirectory = nixosConfig.users.users.alexs.home;

#	home.sessionVariables = {
#	};

	home.packages =
		let
			cliMiscPackages = with pkgs; [
#				(import (builtins.fetchFromGitHub {
#					owner = "Shopify";
#					repo = "comma";
#					rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
#					sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
#				}))
				#(import (builtins.fetchTarball "https://github.com/shopify/comma/archive/master.tar.gz") {})

				(import (builtins.fetchGit {
					url = "https://github.com/shopify/comma";
					ref = "master";
					rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468"; 
				}) {})
				#libsixel
				ffmpeg-sixel # Video streaming (ffserver)
				#arcan.ffmpeg # Video streaming
				gettext # msgmerge
				rsnapshot
				backintime
				partimage
				interception-tools
				#libstdcxx5
				taskwarrior
				imagemagick
				bat # Better cat
				lxsession
				nix-prefetch-git # Find info about repo for Nix
				grub2
				lf
				neofetch # show cool logo and useless info
				pfetch # mini neofetch
				ripgrep # recursively search for files
				fd # 'find' alternative
				flatpak # Run programs in isolated env with deps managed
				lsd # Better ls
				htop # View tasks
				hexyl # View hex files
				jack1
				xboxdrv
				libxkbcommon
				xdg-utils
				libinput
				jq
				pkg-config
				glib-networking
				trash-cli # Recycle bin for windows
				xorg.xhost # For running GParted (cannot open display :0), see gparted-run
				xorg.libXcomposite

				pandoc
				#tetex
				texlive.combined.scheme-full

				rnix-lsp # LSP for Nix Expression Language
			];

			guiMiscPackages = with pkgs; [
				gtk-engine-murrine
				gtk_engines
				gsettings-desktop-schemas
				glib
				gtk3
				hicolor-icon-theme
				transmission-remote-gtk
				gnome3.adwaita-icon-theme
				gnome-breeze

				thunderbird
				agenda
				mupdf
				plasma5Packages.kdenlive
				gimp
				webcamoid
				agenda
				pcmanfm
				klavaro
				barrier
				libsForQt5.kompare
				qemu

				mpv
				sxiv
				dragon-drop
				libnotify
				gnome.networkmanagerapplet
				pavucontrol
				libreoffice
				epiphany
				foot
				conky
				libappindicator-gtk3

				emacs
			] ++ (if isPi then [
			] else [
				etcher
				discord
				zoom-us
				wineWowPackages.stable
				winetricks
				mesa
				lutris
				spotify
				virtualbox
				blender
				appimage-run
				postman
				spotify
				firefox-wayland
				#firefox
				brave
				jetbrainsOverride.idea-community
				teams
				steam
				#steam-tui
				rpcs3
				virtualbox
			]);

			pythonVersion = "python39";

			programmingPackages = with pkgs; [	
				gnumake
				cmake

				gcc10
				#clang_11
				clang-tools
				flex
				bison
				boost175
				ccls

				cargo
				rust-analyzer
				rustc
				rustfmt

				gradle
				maven
				jdk11
				#openjfx15
				#scenebuilder

				#pkgs."${pythonVersion}"

				cabal2nix
				cabal-install
				ghc

				nodejs
				nodePackages.nodemon

				vala_0_50
				gnome.vte

				lean

				#mongodb-4_2
				mongodb

			];

			#pythonPackages = with pkgs."${pythonVersion}Packages"; [
			pythonPackages = packages: with packages; [
				#bpython
				numpy
				pyglet
				cython
				pynvim
				tasklib
			];
			haskellPackages = with pkgs.haskellPackages; [
				haskell-language-server
				hoogle
				ghcid

				vector
                #ghc-vis
			];

			swayPackages = with pkgs; [
				swayidle # Customise idle behaviour
				##swaylock # Lock screen
				swaylock-effects # Various fancy effects
				#unstable.waybar # Info bar
				grim # Take screenshot
				slurp # Select area on screen
				#mako # Notifications
				wl-clipboard # Pipe: copy to clipboard
				kanshi
				xdg-desktop-portal-wlr
				dmenu # Simple fuzzy item selection
				wofi # Wayland rofi, dmenu alternative
				wob # Show progress bar
				flashfocus # Flash on window focus
				libinput
				libappindicator
				brightnessctl # Control screen brightness
				wf-recorder
				libinput-gestures
				gammastep
			];
		in cliMiscPackages
		++ guiMiscPackages
		++ programmingPackages
		++ haskellPackages
		++ swayPackages
		++ [(python38.withPackages pythonPackages)]
	;

	programs.bat.enable = true;

	programs.neovim = {
		enable = true;
		vimAlias = true;
		withPython3 = true;
		extraConfig = readConfig /nvim/init.vim;
		plugins =
			let mathematic-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "mathematic-vim";
				version = "2.60";
				src = pkgs.fetchFromGitHub {
					owner = "gu-fan";
					repo = "mathematic.vim";
					rev = "e57ec0d767fee83f95994b1a8d5cc82395198a49";
					sha256 = "02w05bmzq5f6ry8b0kw5mkx4rnqwampjn9lx9jcagw53h4jmir0p";
				};
			};
			ctrlsf-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "ctrlsf-vim";
				version = "2.60";
				src = pkgs.fetchFromGitHub {
					owner = "dyng";
					repo = "ctrlsf.vim";
					rev = "253689525fddfcb78731bac2d5125b9579bfffb0";
					sha256 = "1xpff867cj1wyqd4hs7v12p7lsmrihmav2z46452q59f6zby5dp4";
				};
			};
			vim-lf = pkgs.vimUtils.buildVimPluginFrom2Nix {
#				pname = "vim-lf";
#				src = pkgs.fetchFromGitHub {
#					owner = "khadegd";
#					repo = "vim-lf";
#					rev = "47de9abbc79a7c0a124f08054add0e2cedb90d89";
#					sha256 = "1syqrdzld616zbwixb9kc2kkr3bbc5c9dzmzffdjbyy60i0ynqys";
#				};
				pname = "vim-lf";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "longkey1";
					repo = "vim-lf";
					rev = "558634097fe02abd025100158c20277618b8bab2";
					sha256 = "06f3lz4dkslnhysl0jcykm4b2pnkazjjpafnxlhz4qsrf21jqkfm";
				};
			};
			vim-maximizer = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "vim-maximizer";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "szw";
					repo = "vim-maximizer";
					rev = "2e54952fe91e140a2e69f35f22131219fcd9c5f1";
					sha256 = "031brldzxhcs98xpc3sr0m2yb99xq0z5yrwdlp8i5fqdgqrdqlzr";
				};
			};
			switch-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "lean-nvim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "andrewradev";
					repo = "switch.vim";
					rev = "900c5d3ee79b1771c5e07bf7290068ea35881756";
					sha256 = "03fabz2xj69mwb52m3a1y9hlc0v62d0c2ysk7jjznx4mkq303cfm";
				};
			};
			lean-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "lean-nvim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "Julian";
					repo = "lean.nvim";
					rev = "74a222956b4f8db47ac8e3f5a48225c9afa7b6eb";
					sha256 = "19czdjy01xph8k61gclf5fqryfmml1i6vxgjjlczzhnvc763n4wq";
				};
				dependencies = with vimPlugins; [
					switch-vim
					nvim-lspconfig
					plenary-nvim
				];
			};
			zen-mode-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "zen-mode-nvim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "folke";
					repo = "zen-mode.nvim";
					rev = "935a58307b64ce071689ba8ee915af5b9cdfe70c";
					sha256 = "09s7jn48nszha8j4r9r52qacc3gvhxka43am5g1wzlqxqcvns9fp";
				};
			};
			in
			with pkgs.vimPlugins; [
				# Aesthetics
				gruvbox # Nice colour scheme
				vim-airline # Line at bottom of screen
				vim-airline-themes

				#nvim-treesitter # Better syntax hightlighting

				#vim-bufferline
        	    #nvim-bufferline-lua
				#barbar-nvim # Better tabs
				nvim-web-devicons

				vim-smoothie # Smooth scrolling

				# Language support
				nvim-lspconfig

				vim-nix
				vim-fish
                i3config-vim

				#vim-lean
				lean-nvim

				vim-markdown # MD support
				markdown-preview-nvim

				haskell-vim
				ghcmod-vim # Types inline

				coc-nvim
				coc-python
				coc-clangd
				coc-rls
				coc-css
				coc-html
				coc-tsserver
				coc-json
				coc-cmake
				coc-java

				# Utilities
				suda-vim # sudo, but without launching Vim with sudo
				vim-maximizer # makes window fill screen
				zen-mode-nvim
				auto-pairs # Pairs, adds spaces, newline support
				nvim-colorizer-lua # Highlights colour codes in cod
				vimsence # Discord rich presence
				vim-hoogle # Hoogle search within Vim
				emmet-vim # generate HTML (like zen coding)
				nvim-compe # Completion

				vimwiki # note-taking
				taskwiki

				mathematic-vim # For extra maths symbols
				vim-highlightedyank # Shows what's copied

				# Movement
				vim-sneak
				ctrlp-vim
				telescope-nvim
				ctrlsf-vim
				vim-floaterm
				lf-vim
				vim-lf
				fzf-vim
				
				# Git
				vim-signify
				vim-fugitive
				vim-rhubarb
				vim-gitbranch

				# Misc
				plenary-nvim
			];
			extraPackages = with pkgs; [
				(python3.withPackages (ps: with ps; [
					pynvim
					tasklib
				]))
				nodejs
			];
			extraPython3Packages = (ps: with ps; [
				pynvim
				tasklib
			]);
       };
    	xdg.configFile."nvim/coc-settings.json".text = readConfig /nvim/coc-settings.json;

	xdg.mimeApps = {
		enable = true;
#		addedAssociations = {
#		};
		defaultApplications = {
			"text/markdown" = "nvim.desktop";
			"image/png" = "sxiv.desktop";
			"image/jpeg" = "sxiv.desktop";
			"image/gif" = "sxiv.desktop";
			"video/mp4" = "mpv.desktop";
			"image/pdf" = "mupdf.desktop";

			"x-scheme-handler/discord-424004941485572097"="discord-424004941485572097.desktop";
			"x-scheme-handler/postman" = "Postman.desktop";
			"x-scheme-handler/msteams" = "teams.desktop";
		}; # Check ~/.config/mimeapps.list for collisions
	};

	programs.mako = {
		# https://github.com/nix-community/home-manager/blob/master/modules/services/mako.nix
		enable = true;
		maxVisible = 5;
		sort = "+time";
		anchor = "bottom-right";
		font = pangoFont 10;
		backgroundColor = "#" + gruvboxTheme.bg + "CC";
		borderRadius = 2;
		borderColor = "#" + gruvboxTheme.yellow;
		defaultTimeout = 5000;
	};

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

	programs.waybar = {
		enable = true;
    };
	xdg.configFile."waybar/config".text = readConfig /waybar/config;
	xdg.configFile."waybar/style.css".text = readConfig /waybar/style.css;
	xdg.configFile."waybar/colours.css".text = readConfig /waybar/colours.css;

	programs.alacritty = {
		enable = true;
	};
	xdg.configFile."alacritty/alacritty.yml".text = readConfig /alacritty/themes/gruvbox-material-alacritty.yml;

	programs.foot = {
		enable = true;
		settings = {
			main = {
				term = "foot";
				font = "monospace:size=9";
				dpi-aware = "yes";
			};
			colors = with gruvboxTheme; {
				background = bg;
				foreground = fg;
				regular0 = bg;
				regular1 = red;
				regular2 = green;
				regular3 = yellow;
				regular4 = blue;
				regular5 = purple;
				regular6 = aqua;
				regular7 = gray;
				bright0 = "928374";
				bright1 = "fb4934";
				bright2 = "b8bb26";
				bright3 = "fabd2f";
				bright4 = "83a598";
				bright5 = "d3869b";
				bright6 = "8ec07c";
				bright7 = "ebdbb2";
			};
		};
	};

	programs.fish = {
		enable = true;
		shellInit = readConfig /fish/icons.fish;
#		loginShellInit = ''
#			if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
#				exec sway
#				exec 'sudo udevmon -c ${homeConfigDir}/sway/scripts/job.yaml'
#			end
#		'';
		shellAliases = {
			exe = "result/bin/*";
			ls = "lsd";
			nix-pr = "/nix/var/nix/profiles/system";
			avg-core-temp = "cat /sys/class/thermal/thermal_zone*/temp | awk '{ sum += $1 } END { print sum / NR }'";
		};
		functions = {
			project-new = {
				description = "Creates a new project in dump and link to current location";
				body = ''
					set link_path (pwd)
					set project_path "${devDir}/.dump/projects/$argv[1]"
					mkdir $project_path
					ln -s $project_path $name
					cd $project_path
                    "$link_path/.gen.fish" $link_path
				'';
#					printf "%s\n" \
#						"with import <nixpkgs> { };" \
#						"mkShell {" \
#						"	buildInputs = [ $argv[2..-1] ];" \
#						"}" > $project_path/shell.nix
			};
			project-del = {
				description = "Deletes project in dump and deletes link in current directory";
				body = ''
					for name in $argv
						rm -r $project_path "${devDir}/.dump/projects/$name"
						rm $name
					end
				'';
			};
			project-list-all = {
				description = "Lists all projects in dump";
				body = ''
					ls ${devDir}/.dump/projects
				'';
			};
			__informative_git_prompt = {
				description = "Provides git information";
				body = readConfig /fish/functions/__informative_git_prompt.fish;
			};

			list = {
				description = "Interactive list pdfs and select";
				body = ''
				set i 1
				set ext $1
				if test -z $ext
					set ext "pdf"
				end
				
				set files (find . -name "*.$ext")
				for f in $files
					echo $i": " $f
					set i (math $i+1)
				end
				read -a choices
				for n in $choices
					mupdf $files[$n] &
				end
				'';
			};

			pkg-search = {
				description = "Search for Nix package";
				body = ''
					nix-env -f '<nixpkgs>' -qaP -A $argv
				'';
			};

			gparted-run = {
				description = "Run gparted";
				body = ''
					xhost +local:
					gparted
				'';
			};
			kdenlive-run = {
				description = "Run kdenlive on Wayland";
				body = ''
					QT_QPA_PLATFORM=xcb kdenlive
				'';
			};
		};
	};
	#xdg.configFile."fish/functions/__informative_git_prompt.fish".text = readConfig /fish/functions/__informative_git_prompt.fish;
	xdg.configFile."fish/functions/fish_prompt.fish".text = ''
		. ${homeConfigDir}/fish/functions/__informative_git_prompt.fish
		${readConfig /fish/functions/fish_prompt.fish};
	'';

	xdg.configFile."lf/lfrc".text = readConfig /lf/lfrc;
	home.file."nixos/home-manager/config/sway/scripts/job.yaml".text = ''
- JOB: ${pkgs.interception-tools}/bin/intercept -g $DEVNODE | /home/alexs/apps/caps2esc-master/build/caps2esc| ${pkgs.interception-tools}/bin/uinput -d $DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [BTN_BACK, BTN_RIGHT]'';
	

	programs.git = {
		enable = true;
		userName = "pseud0n";
		userEmail = "pseud0n@users.noreply.github.com";
        # SSH key stored locally
	};
	
#	programs.firefox = {
#		enable = true;
#		extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#			privacy-badger
#			https-everywhere
#		];
#		profiles.default = {
#			id = 0;
#			settings = {
#				"browser.search.defaultenginename" = "Ecosia";
#				"font.name.monospace.x-western" = "FiraCode Nerd Font Mono";
#			};
#		};
#	};

	home.stateVersion = "21.05";
}
