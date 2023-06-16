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
	defaultTerminal = "terminator";
	devDir = "$HOME/dev";

	readConfig = path: builtins.readFile (homeConfigDir + path);

	isPi = builtins.currentSystem == "aarch64-linux";

	jetbrainsOverride = import ./pins/jetbrains/default.nix {
		inherit lib stdenv callPackage fetchurl
		cmake zlib python3
		autoPatchelfHook
		dotnet-sdk_6
		maven
		gdb
		libdbusmenu;
		jdk = jdk11;
	};
	burpsuiteOverride = import ./pins/burpsuite.nix {
		inherit fetchurl lib stdenv runtimeShell chromium jdk11 unzip;
	};
	nix-alien-pkgs = import (
		fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
	  ) { };
	doom-emacs = pkgs.callPackage (builtins.fetchTarball {
		url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
	}) {
		doomPrivateDir = ./config/emacs/doom.d;
		# Directory containing your config.el init.el
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
			services.tumbler.enable = true;
			programs.home-manager.enable = true;
			programs.wireshark.enable = true;
			allowUnfree = true;
			allowBroken = false;
			permittedInsecurePackages = [
				"electron-12.2.3"
				#"polymc-1.2.2"
			];
		};
		overlays = [
			#(import ./overlays/firefox-overlay.nix)
		];
	};

	imports = [
		(import config/fish/fish.nix { inherit devDir homeConfigDir; })
		config/neovim/neovim.nix
		#config/git/git.nix
		#config/alacritty/alacritty.nix
		#config/openbox/openbox.nix
		#config/lf/lf.nix
		#config/conky/conky.nix
		#config/eww/eww.nix
		#config/sway/sway.nix
		#config/waybar/waybar.nix
		#(import config/foot/foot.nix { inherit gruvboxTheme; })
		#(import config/mako/mako.nix { inherit pangoFont gruvboxTheme; })
		#<nix-ld/modules/nix-ld.nix>
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
		EDITOR = "emacs";
	};

	services = {
		picom.enable = true;
		emacs = {
			enable = true;
			#package = doom-emacs;
		};
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    redshift = {
      enable = true;
      longitude = 50.0;
      latitude = 0.0;
    };
	};

	home.packages =
		let
			cliMiscPackages = with pkgs; [
#				(import (builtins.fetchGit {
#					url = "https://github.com/shopify/comma";
#					ref = "master";
#					rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
#				}) {})
				#jack1
				arj # ARJ open source implementation
        arp-scan
				aspell
				at-spi2-core
				#avrlibc
				#avrlibcCross
				bat # better cat
        batsignal # battery
				bc # maths in shell
				bear
				brightnessctl
				#busybox # Various bits
				cava # cool audio visualiser
				comma
        coreutils-prefixed
				dcfldd
				dmidecode
				dos2unix
				fd # 'find' alternative
				file # file info
				flatpak # run programs in isolated env with deps managed
				ffmpeg # video/audio editing
				fzy
				gettext # msgmerge
				ghostscript
				glib
				glib-networking
				gnupg
				graphviz
				hexyl # view hex files
				htop # view tasks
				httrack # download websites
				id3v2 # music tagging
				imagemagick # image editing, functions
				jgmenu # customisable menu
				jmtpfs # media transfer protoocl file system
				jq # JSON
				killall # kill processes
				lame # audio codec
				lf # file manager
				lhasa # lha free implementation
				libinput # mouse input
				libxkbcommon
				lsd # better ls
        mlocate
				neofetch # show cool logo and useless info
        #netcat-gnu
				#nix-alien-packages.nix-alien
				#nix-alien-packages.nix-index-update
				nix-index
				nix-prefetch-git # Find info about repo for Nix
				p7zip # .7z archives
				parted # manage partitions
				pass # password manager
				pinentry-curses # enter password for pass
				pfetch # mini neofetch
				playerctl # media keys and watch media
				pkg-config
        power-profiles-daemon
				#protonmail-bridge
				ripgrep # recursively search for files
				redshift # screen colour
				rnix-lsp # LSP for Nix Expression Language
				taskwarrior # organise tasks
				texlive.combined.scheme-tetex
				tlp # Battery management
				touchegg # touchpad
				trash-cli # Recycle
				udisks # mounting
				wmctrl # window manager functions
				xboxdrv # Xbox controller suppport
				xdg-utils
				#xlibsWrapper
				#xorg.libX11.dev
				#xorg.libXcomposite
				xorg.xev # track key events, mouse movement
				xorg.xhost # For running GParted (cannot open display :0), see gparted-run
				xorg.xinit
				xorg.xmodmap # keyboard
        zfs # interact with ZFS
				zip # archives
			];

			guiMiscPackages = with pkgs; [
				#eclipses.eclipse-java
				#foot
				#glib
				#gnome-breeze
				#gsettings-desktop-schemas
				#gtk-engine-murrine
				#gtk3
				#gtk_engines
				#latest.firefox-nightly-bin # firefox-overlay.nix
				#qemu
				#steam-tui
				#transmission-remote-gtk
				agenda # list tasks
				appimage-run # run appimage
				arandr # GUI for monitors
				arduino # microcontroller tools
				artha # thesaurus
				audacious # music player
				audacity # audio editing
				barrier # for multiple devices
				blender # 3d modelling
				#brave
				burpsuiteOverride
				chromium
				clementine # music player
				colorpicker # pick colours
				conky # desktop widget things
				connman # connection manager
				connman-gtk
				connman-ncurses
				connman-notify
				cpu-x # show CPU info + more
				deluge # torrenting
				discord # chat/social app
				#doom-emacs
				dmenu # menu for options
				#dolphin
				dunst
				emacs # text editor and much more
				emote # emoji selet
				#epiphany # simple web browser
				etcher # flashing tool
				eww # bars and widgets
        fabric-installer
				feh # display image, set background
				#firefox-esr
				flameshot # taks screenshots
				freecad # 3d modelling/CAD/part design
				fstl # simple STL viewer
				ghidra
				gimp # image editro
				gnome3.adwaita-icon-theme
				gpick
				gsimplecal
				guake
				guvcview
				gxkb
				hashcat
				hicolor-icon-theme
				inkscape
				jetbrains.idea-community
				john # password cracking
				klavaro # typing tutor
				kphotoalbum
				libappindicator-gtk3
				libnotify
				libreoffice
				#librewolf
				libsForQt5.kdeconnect-kde
				libsForQt5.kompare
				lutris
				lxappearance
				polkit_gnome
				lxqt.lxqt-notificationd
				lxqt.lxqt-powermanagement
				lxqt.lxqt-qtplugin
				lxqt.lxqt-runner
				lxqt.pavucontrol-qt
				lxqt.qlipper
				lxqt.qterminal
				lxsession
				lxtask
				mesa
				mono
				mpv
				mupdf
				networkmanagerapplet
				numix-gtk-theme
				numix-icon-theme
				numix-cursor-theme
				obconf
				obs-studio
				oneko
				onboard
				pamixer
				parcellite
				pavucontrol
				#pcmanfm
				picom
				plasma5Packages.kdenlive
				#polymc
				postman
				prismlauncher
				qalculate-gtk
				qtpass
				rofi
				rofi-emoji
				rpcs3
				selectdefaultapplication
				scilab-bin
				skippy-xd
				spotify
				steam
				strawberry
				sxiv
				tdesktop # Telegram
				teams
				terminator
				texmacs
				thunderbird
				tint2
				trayer
				tor
				tor-browser-bundle-bin
        uget
				#ungoogled-chromium
				#virtualbox
				v4l-utils
				viewnior
				vivaldi
				vlc
        vokoscreen
				volumeicon
				webcamoid
				weka
				wine-staging
				wineWowPackages.stable
				winetricks
        wireshark
				worker
				#write_stylus
				xarchiver # archiver frontend
				xdotool
				xdragon
				#xfce.ristretto
				xfce.thunar
				#xfce.tumbler
				xob
				xorg.xauth
				xorg.xbacklight
				xournal
				xournalpp
				xscreensaver
				xterm
				youtube-dl
				zoom-us
			] ++ (if isPi then [
			] else [
			]);

			pythonVersion = "python39";

			androidPackages = with pkgs; [
        adbfs-rootless
        android-file-transfer
				android-tools
				libmtp
				mtpfs
				jmtpfs
			];

      emacsPackages = with pkgs.emacsPackages; [
        captain
        editorconfig
      ];

			programmingPackages = with pkgs; [
				nixfmt
				gnumake
				cmake
				sqlite
				gcc
				#clang
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
				openjfx17
				#postgresql_jdbc
				#postgresql
				#scenebuilder
				#java-language-server

				#pkgs."${pythonVersion}"

				vlang

				nodejs
				nodePackages.nodemon
				yarn

				#lean

				#mongodb-4_2
				#mongodb

				leiningen

				gprolog

				valgrind
				cargo-valgrind
				glslang
				shellcheck
				clj-kondo
				jsbeautifier
				html-tidy

		#bootloadhid
        qmk

			];

			lispPackages = with pkgs; with pkgs.lispPackages; [
				clisp
				sbcl
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
				tkinter
				pythonefl
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
			enlightenmentPackages = with pkgs.enlightenment; [
				#efl
				#enlightenment
				#econnman
				terminology
				#e17gtk
				evisum
				rage
				#ecrire
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
		++ emacsPackages
		++ programmingPackages
		++ androidPackages
		++ haskellPackages
		++ lispPackages
#		++ swayPackages
#		++ gnomePackages
		++ enlightenmentPackages
		++ [(python39.withPackages pythonPackages)]
	;

	programs.bat.enable = true;
	#programs.nix-ld.enable = true;

	#programs.dconf.enable = true;

	#xdg.configFile."nvim/coc-settings.json".text = readConfig /nvim/coc-settings.json;

#	xdg.mimeApps = {
#		enable = true;
#		defaultApplications = {
#			"application/x-extension-htm" = "vivaldi-stable.desktop";
#			"application/x-extension-html" = "vivaldi-stable.desktop";
#			"application/x-extension-shtml" = "vivaldi-stable.desktop";
#			"application/x-extension-xht" = "vivaldi-stable.desktop";
#			"application/x-extension-xhtml" = "vivaldi-stable.desktop";
#			"application/xhtml+xml" = "vivaldi-stable.desktop";
#			"application/zip" = "userapp-unzip-9C58H1.desktop";
#			#"image/pdf" = "vivaldi.desktop";
#			"image/*" = "sxiv.desktop";
#			"audio/*" = "mpv.desktop";
##			"image/jpeg" = "sxiv.desktop";
##			"image/png" = "sxiv.desktop";
#			"inode/directory" = "worker.desktop";
#			#"text/html" = "vivaldi-stable.desktop";
#			"text/*" = "emacs.desktop";
#			"video/*" = "mpv.desktop";
#
#			"x-scheme-handler/etcher" = "balena-etcher-electron.desktop";
#			"x-scheme-handler/discord-424004941485572097" = "discord-424004941485572097.desktop";
#			"x-scheme-handler/http" = "vivaldi-stable.desktop";
#			"x-scheme-handler/https" = "vivaldi-stable.desktop";
#			"x-scheme-handler/mailto" = "thunderbird.desktop";
#			"x-scheme-handler/msteams" = "teams.desktop";
#			"x-scheme-handler/postman" = "Postman.desktop";
#
#			"x-scheme-handler/about" = "vivaldi-stable.desktop";
#			"x-scheme-handler/unknown" = "vivaldi-stable.desktop";
#
#
#		}; # Check ~/.config/mimeapps.list for collisions
#	};
	home.file.".emacs.d/init.el".text = ''
		(load "default.el")
	'';
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

	home.stateVersion = "22.05";
}
