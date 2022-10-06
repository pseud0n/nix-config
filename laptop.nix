{config, lib, pkgs, ...}:
{
	boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
	# pkgs.linuxPackages_4_14
	# pkgs.linuxPackages_4_14_hardened
	# pkgs.linuxPackages_4_19
	# pkgs.linuxPackages_4_19_hardened
	# pkgs.linuxPackages_4_4
	# pkgs.linuxPackages_4_9
	# pkgs.linuxPackages_5_10
	# pkgs.linuxPackages_5_10_hardened
	# pkgs.linuxPackages_5_15
	# pkgs.linuxPackages_5_15_hardened
	# pkgs.linuxPackages_5_16
	# pkgs.linuxPackages_5_17
	# pkgs.linuxPackages_5_4
	# pkgs.linuxPackages_5_4_hardened
	# pkgs.linuxPackages_custom
	# pkgs.linuxPackages_custom_tinyconfig_kernel
	# pkgs.linuxPackages_hardened
	# pkgs.linuxPackages_hardkernel_4_14
	# pkgs.linuxPackages_hardkernel_latest
	# pkgs.linuxPackages_latest
	# pkgs.linuxPackages_latest-libre
	# pkgs.linuxPackages_latest_hardened
	# pkgs.linuxPackages_latest_xen_dom0
	# pkgs.linuxPackages_latest_xen_dom0_hardened
	# pkgs.linuxPackages_lqx
	# pkgs.linuxPackages_mptcp
	# pkgs.linuxPackages_rpi0
	# pkgs.linuxPackages_rpi1
	# pkgs.linuxPackages_rpi2
	# pkgs.linuxPackages_rpi3
	# pkgs.linuxPackages_rpi4
	# pkgs.linuxPackages_rt_5_10
	# pkgs.linuxPackages_rt_5_4
	# pkgs.linuxPackages_testing
	# pkgs.linuxPackages_testing_bcachefs
	# pkgs.linuxPackages_testing_hardened
	# pkgs.linuxPackages_xanmod
	# pkgs.linuxPackages_xen_dom0
	# pkgs.linuxPackages_xen_dom0_hardened
	# pkgs.linuxPackages_zen
	boot.kernelModules = [ "wl" ]; # set of kernel modules loaded in second stage of boot process
	boot.initrd.kernelModules = [ "wl" "kvm-intel" ]; # list of modules always loaded by the initrd (initial ramdisk)
	boot.kernelPackages = pkgs.linuxPackages;

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		setLdLibraryPath = true;
	};

	hardware.pulseaudio.support32Bit = true;

	# Enable CUPS to print documents.
	# https://nixos.wiki/wiki/Printing
	services.printing = {
		enable = true;
		drivers = with pkgs; [
			# Pixma
			cnijfilter2
		];
	};

	# Use the systemd-boot EFI boot loader.
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi = {
				canTouchEfiVariables = true;
			};
			grub = {
				version = 2;
				device = "nodev";
				extraEntries =  ''
					menuentry "Windows" {
							set root=(hd0,1)
				    		chainloader +1
				  	}
  				'';

			};
		};
	};
}

