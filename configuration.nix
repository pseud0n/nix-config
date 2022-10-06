# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# https://nixos.org/channels/nixos-unstable unstable
# https://channels.nixos.org/nixos-21.05 nixos

{ config, lib, pkgs, ... }:

let
	#unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
	user = "alexs";
	home = "/home/${user}";
	isPi = builtins.currentSystem == "aarch64-linux"; #!= "x86_64-linux";
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			#./grub-savedefault.nix
			#(import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-21.05.tar.gz}/nixos")
			#./home-manager/home.nix
			<home-manager/nixos>
		] ++ (if isPi then [
			"${builtins.fetchTarball https://github.com/NixOS/nixos-hardware/archive/refs/tags/mnt-reform2-nitrogen8m-v1.tar.gz}/raspberry-pi/4"
			#"${builtins.fetchTarball https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz}/raspberry-pi/4"
			./pi.nix
		] else [
			./laptop.nix
		]);

	nixpkgs.config.allowUnfree = true; # proprietary drivers
#	nixpkgs.config.permittedInsecurePackages = [
#		"libsixel-1.8.6"
#	];

	nixpkgs.config.packageOverrides = pkgs: with pkgs;{
	        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
	        	inherit pkgs;
        	};

	};

	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.tmpOnTmpfs = true; # use primary memory for /tmp
	networking = {
		networkmanager = {
			enable = true;
			wifi.scanRandMacAddress = false;
		};
		useDHCP = false;
		interfaces.eno1.useDHCP = true;
		hostName = "nixos";
		#enableB43Firmware = true;
	};

	time.timeZone = "Europe/London";

	# The global useDHCP flag is deprecated, therefore explicitly set to false here.
	# Per-interface useDHCP will be mandatory in the future, so this generated config
	# replicates the default behaviour.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "uk";
	};

	xdg.portal.enable = true;
	systemd.services.upower.enable = true;

	#programs.xwayland.enable = true;
	programs.java.enable = true;
	virtualisation = {
		docker.enable = true;
		virtualbox.host = {
			enable = true;
			enableExtensionPack = true;
		};
	};
	services = {

		#udev.extraHwdb = # Bus 001 Device 008: ID 0c45:760b Microdia USB Keyboard
		#''
		#evdev:input:b0003v0C45p760B*
		#		KEYBOARD_KEY_70039=esc
		#'';

		udev.packages = with pkgs; [
			numworks-udev-rules
		];

		flatpak.enable = true;
	 	gnome.gnome-keyring.enable = true;
		touchegg.enable = true;
	 	upower.enable = true;
		tor.enable = true;
		mongodb = {
			enable = true;
			dbpath = "${home}/data/db";
			user = "alexs";
		};
		xserver = {
			enable = true;
			libinput.enable = true;
			desktopManager = {
			};
			#videoDrivers = with pkgs; [
			#	driversi686Linux.mesa
			#];
			windowManager = {
				openbox.enable = true;
			};
			displayManager = {
				defaultSession = "none+openbox";
				lightdm.enable = true;
				gdm = {
					enable = false;
					wayland = false;
				};
				lightdm.greeters.mini = {
					enable = true;
					user = user;
					extraConfig = ''
						[greeter]
						show-password-label = false
						password-alignment = center
						user = ${user}
						invalid-password-text = ×

						[greeter-theme]
						window-color = "#5b00f0"
						font-size = 0.8em
						background-image = "/home/alexs/Pictures/bg/no-confluence-purple.png"
						layout-space = 30
						border-width = 0px

						[greeter-hotkeys]
						mod-key = meta
						shutdown-key = s
						restart-key = r
						hibernate-key = h
						suspend-key = u
					'';
				};
			};
			layout = "gb";
		};
		postgresql = {
			enable = true;
			package = pkgs.postgresql_14;
			authentication = lib.mkForce ''
				# Generated file; do not edit!
				# TYPE  DATABASE        USER            ADDRESS                 METHOD
				local   all             all                                     trust
				host    all             all             127.0.0.1/32            trust
				host    all             all             ::1/128                 trust
				'';
		};
	};

	environment = {
		variables = {
		};
		#gnome.excludePackages = with pkgs.gnome; [ cheese gnome-photos gnome-music gnome-terminal gedit epiphany evince gnome-characters totem tali iagno hitori atomix geary ];
	};

	#programs.sway.enable = true;
#	programs.sway = {
#		enable = true;
#		wrapperFeatures.gtk = true;
#	};

	sound.enable = true;
	hardware = {
		enableAllFirmware = true;
		pulseaudio = {
			enable = true;
			package = pkgs.pulseaudioFull;
			extraModules = [];
		};
		bluetooth = {
			enable = true;
			settings = {
				General = {
					Enable = "Source,Sink,Media,Socket";
				};
			};
		};
	};
	services.blueman.enable = true; # If no GUI available

	programs.fish.enable = true;

	#security.doas = {
	#	enable = true;
	#	extraRules = [{
	#	    users = [ user ];
	#	    keepEnv = true;
	#	}];
	#	extraConfig = "permit :wheel";
	#};

	home-manager.users."${user}" = import ./home-manager/home.nix; 
	users = {
		users."${user}" = {
			shell = pkgs.fish;
			home = home;
			isNormalUser = true;
			extraGroups = [ "wheel" "video" "networkmanager" "dialout" "docker" "bluetooth" "vboxusers" ]; # Enable ‘sudo’ for the user.
		};
	   extraGroups.vboxusers.members = [ user ];
	};

	fonts.fonts = with pkgs; [
#		noto-fonts
#		noto-fonts-cjk
#		noto-fonts-emoji
#		liberation_ttf
#		fira-code
#		fira-code-symbols
#		mplus-outline-fonts
#		dina-font
#		proggyfonts
		(nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
	];

	environment.pathsToLink = [ "/libexc" ];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# The essentials
		nano
		vim
		neovim
		leafpad

		epiphany

		git

		vulkan-tools

		gparted

		fish
		wget
		curl
		xclip
		pciutils
		usbutils
		wirelesstools
		networkmanager
		unzip
		libsecret
		usermount
		#broadcom-bt-firmware
		bluez
		bluez-tools
		bluez-alsa

		xorg.libX11
	];

#	system.activationScripts = {
#		swaySetup = ''
#			echo $UID
#			XDG_RUNTIME_DIR=/tmp
#			DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
#			PATH=$PATH:${lib.makeBinPath [ pkgs.which pkgs.mako pkgs.systemdMinimal ]}
#			systemctl --machine=alexs@.host --user
#			which busctl
#			makoctl reload
#			echo BOMBASS
#		'';
#	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#	 enable = true;
	#	 enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	networking.firewall.enable = false;


	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "22.05"; # Did you read the comment? No.

}

