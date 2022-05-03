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
	defaultTerminal = "alacritty";
	devDir = "$HOME/dev";

	readConfig = path: builtins.readFile (homeConfigDir + path);

	isPi = builtins.currentSystem == "aarch64-linux";

	jetbrainsOverride = import ./pins/jetbrains/default.nix {
		inherit lib stdenv callPackage fetchurl
		cmake zlib python3
		dotnet-sdk_5
		autoPatchelfHook
		libdbusmenu;
		jdk = jdk11;
	};

	doom-emacs = pkgs.callPackage (builtins.fetchTarball {
		url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
	}) {
		doomPrivateDir = ./config/emacs/doom.d;  # Directory containing your config.el init.el
									# and packages.el files
	};

	flypie = callPackage ./config/gnome/buildGnomeExtension.nix {
		inherit pkgs lib stdenv;
		fetchzip = pkgs.fetchzip;
	} {
		uuid = "flypie@schneegans.github.com";
		name = "Fly-Pie";
		pname = "flypie";
		description = "A marking menu which can be used to launch applications, simulate hotkeys, open URLs and much more.";
		link = "https://github.com/Schneegans/Fly-Pie";
		version = 13;
		sha256 = "1p8c83ms15x9vbssypw9viixvssfckz2kc9q552mks1s5kgl8vib";
		metadata = ./config/gnome/fly-pie-metadata.json;
	};

	mach-nix = import (
		builtins.fetchGit {
			url = "https://github.com/DavHau/mach-nix/";
			ref = "2.0.0";
		}
	);

in rec {
	nixpkgs = {
		config = {
			programs.home-manager.enable = true;
			allowUnfree = true;
			allowBroken = false;
			permittedInsecurePackages = [
				"electron-14.2.9"
			];
		};
		overlays = [
			#(import ./overlays/firefox-overlay.nix)
		];
	};

	imports = [
		(import config/fish/fish.nix { inherit devDir homeConfigDir; })
		config/neovim/neovim.nix
		config/git/git.nix
		config/alacritty/alacritty.nix
		config/lf/lf.nix
		#config/sway/sway.nix
		#config/waybar/waybar.nix
		#(import config/foot/foot.nix { inherit gruvboxTheme; })
		#(import config/mako/mako.nix { inherit pangoFont gruvboxTheme; })
	];
	home.username = "alexs";
	home.homeDirectory = nixosConfig.users.users.alexs.home;

	home.sessionVariables = {
		TERMINAL = defaultTerminal;
		#QT_QPA_PLATFORM = "wayland";
		#XDG_CURRENT_DESTKOP = "sway";
		#MOZ_ENABLE_WAYLAND = "1";
		#_JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
		JAVA_HOME = "$(dirname $(dirname $(readlink $(readlink $(which javac)))))";
		#GTK_THEME = "Adwaita:dark";
		DEV_DIR = devDir;
		HOME_MANAGER_DIR = homeConfigDir;
		EDITOR = "nvim";
	};

	services = {
		picom.enable = true;
	};

	home.packages =
		let
			cliMiscPackages = with pkgs; [
#				(import (builtins.fetchGit {
#					url = "https://github.com/shopify/comma";
#					ref = "master";
#					rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
#				}) {})
				busybox # Various bits
				cava # Cool audio visualiser
				gettext # msgmerge
				taskwarrior
				imagemagick
				bat # Better cat
				nix-prefetch-git # Find info about repo for Nix
				lf
				neofetch # show cool logo and useless info
				pfetch # mini neofetch
				ripgrep # recursively search for files
				fd # 'find' alternative
				flatpak # Run programs in isolated env with deps managed
				lsd # Better ls
				htop # View tasks
				hexyl # View hex files
				#jack1
				xboxdrv # Xbox controller suppport
				libxkbcommon
				xdg-utils
				libinput
				jq
				pkg-config
				glib-networking
				trash-cli # Recycle
				xorg.xhost # For running GParted (cannot open display :0), see gparted-run
				xorg.libXcomposite
				xorg.xev
				xorg.xmodmap
				brightnessctl
				jmtpfs
				parted
				p7zip
				zip
				lhasa # lha free implementation
				rar
				arj # ARJ open source implementation
				rnix-lsp # LSP for Nix Expression Language
			];

			guiMiscPackages = with pkgs; [
				webcamoid
				xarchiver # archiver frontend
				fstl # Simple STL viewer
				skippy-xd
				#gtk-engine-murrine
				#gtk_engines
				#gsettings-desktop-schemas
				#glib
				#gtk3
				hicolor-icon-theme
				#transmission-remote-gtk
				gnome3.adwaita-icon-theme
				#gnome-breeze
				lxsession
				lxappearance
				lxtask
				lxqt.lxqt-notificationd
				guake
				picom
				rofi
				dmenu
				xorg.xbacklight
				xob
				artha
				deluge
				thunderbird
				agenda
				mupdf
				plasma5Packages.kdenlive
				gimp
				pcmanfm
				dolphin
				xfce.thunar
				klavaro
				barrier
				libsForQt5.kompare
				#qemu
				inkscape
				mpv
				sxiv
				dragon-drop
				libnotify
				gnome.networkmanagerapplet
				pavucontrol
				flameshot
				xob
				pamixer
				libreoffice
				epiphany
				#foot
				conky
				libappindicator-gtk3
				obconf
				emacs
				weka
			] ++ (if isPi then [
			] else [
				etcher
				discord
				zoom-us
				wineWowPackages.stable
				winetricks
				wineStaging
				mono
				mesa
				lutris
				blender
				appimage-run
				postman
				spotify
				firefox
				#latest.firefox-nightly-bin # firefox-overlay.nix
				brave
				tor
				ungoogled-chromium
				jetbrainsOverride.idea-community
				#eclipses.eclipse-java
				teams
				steam
				#steam-tui
				rpcs3
				arduino
				tint2
				feh
				parcellite
				oneko
			]);

			pythonVersion = "python39";

			programmingPackages = with pkgs; [
				gnumake
				cmake

				gcc10
				#clang_11
				#clang-tools
				#flex
				#bison
				#boost175
				ccls

				#cargo
				rust-analyzer
				#rustfmt
				rustup
				#rls

				universal-ctags

				gradle
				maven
				jdk11
				openjfx15
				#scenebuilder
				#java-language-server

				#pkgs."${pythonVersion}"

				vlang

				nodejs
				nodePackages.nodemon

				#lean

				#mongodb-4_2
				mongodb

				leiningen

				gprolog

			];

			lispPackages = with pkgs; with pkgs.lispPackages; [
				clisp
			];

			#pythonPackages = with pkgs."${pythonVersion}Packages"; [
			pythonPackages = packages: with packages; [
				#mach-nix
				bpython
				numpy
				pyglet
				#cython
				pynvim
				tasklib
				#pylint
				#pycodestyle
				#msgpack
				#python-lsp-server
			];
			haskellPackages = with pkgs; with pkgs.haskellPackages; [
				cabal2nix
				cabal-install
				ghc

				haskell-language-server
				hoogle
				ghcid
				vector
                #ghc-vis
			];
			gnomePackages = with pkgs; with pkgs.gnome; with pkgs.gnomeExtensions; [
				gnome-tweaks
				mousetweaks
				user-themes
				hide-top-bar
				tiling-assistant
				custom-hot-corners-extended
				dash-to-panel
				sound-output-device-chooser
				x11-gestures
				gtile
				clipboard-indicator
				titlebar-screenshot
				scroll-panel
				battery-threshold
				autohide-volume
				autohide-battery
				workspace-indicator-2
				tint-all
				internet-speed-monitor
				vitals

				#flypie

				touchegg
			];
#			swayPackages = with pkgs; [
#				swayidle # Customise idle behaviour
#				##swaylock # Lock screen
#				swaylock-effects # Various fancy effects
#				#unstable.waybar # Info bar
#				grim # Take screenshot
#				slurp # Select area on screen
#				#mako # Notifications
#				wl-clipboard # Pipe: copy to clipboard
#				kanshi
#				xdg-desktop-portal-wlr
#				dmenu # Simple fuzzy item selection
#				wofi # Wayland rofi, dmenu alternative
#				wob # Show progress bar
#				flashfocus # Flash on window focus
#				libinput
#				libappindicator
#				brightnessctl # Control screen brightness
#				wf-recorder
#				libinput-gestures
#				gammastep
#			];
		in cliMiscPackages
		++ guiMiscPackages
		++ programmingPackages
		++ haskellPackages
		++ lispPackages
#		++ swayPackages
		++ gnomePackages
		++ [(python39.withPackages pythonPackages)]
	;

	programs.bat.enable = true;

	#xdg.configFile."nvim/coc-settings.json".text = readConfig /nvim/coc-settings.json;

	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"application/x-extension-htm" = "firefox.desktop";
			"application/x-extension-html" = "firefox.desktop";
			"application/x-extension-shtml" = "firefox.desktop";
			"application/x-extension-xht" = "firefox.desktop";
			"application/x-extension-xhtml" = "firefox.desktop";
			"application/xhtml+xml" = "firefox.desktop";
			"application/zip" = "userapp-unzip-9C58H1.desktop";
			"image/gif" = "sxiv.desktop";
			"image/jpeg" = "sxiv.desktop";
			"image/pdf" = "firefox.desktop";
			"image/png" = "sxiv.desktop";
			"inode/directory" = "thunar.desktop";
			"text/html" = "firefox.desktop";
			"text/markdown" = "nvim.desktop";
			"video/mp4" = "mpv.desktop";

			"x-scheme-handler/etcher" = "balena-etcher-electron.desktop";
			"x-scheme-handler/discord-424004941485572097" = "discord-424004941485572097.desktop";
			"x-scheme-handler/http" = "firefox.desktop";
			"x-scheme-handler/https" = "firefox.desktop";
			"x-scheme-handler/mailto" = "thunderbird.desktop";
			"x-scheme-handler/msteams" = "teams.desktop";
			"x-scheme-handler/postman" = "Postman.desktop";


		}; # Check ~/.config/mimeapps.list for collisions
	};
  home.file.".emacs.d" = {
    # don't make the directory read only so that impure melpa can still happen
    # for now
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "26b8fe0c317915b622825877eb5e5bdae88fb2b2";
      sha256 = "00cfm6caaz85rwlrbs8rm2878wgnph6342i9688w4dji3dgyz3rz";
    };
  };
#	home.file."nixos/home-manager/config/sway/scripts/job.yaml".text = ''
#- JOB: ${pkgs.interception-tools}/bin/intercept -g $DEVNODE | /home/alexs/apps/caps2esc-master/build/caps2esc| ${pkgs.interception-tools}/bin/uinput -d $DEVNODE
#  DEVICE:
#    EVENTS:
#      EV_KEY: [BTN_BACK, BTN_RIGHT]'';

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

	home.stateVersion = "21.11";
}
