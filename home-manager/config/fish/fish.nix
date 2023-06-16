{ homeConfigDir, devDir}:
{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
	xdg.configFile."fish/functions/fish_prompt.fish".text = ''
		. ${homeConfigDir}/fish/functions/__informative_git_prompt.fish
		${builtins.readFile ./functions/fish_prompt.fish};
	'';
	programs.fish = {
		enable = true;

		shellInit = builtins.readFile ./icons.fish;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = with pkgs.fishPlugins; [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
		];

#		loginShellInit = ''
#			if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
#				exec sway
#				exec 'sudo udevmon -c ${homeConfigDir}/sway/scripts/job.yaml'
#			end
#		'';
		shellAliases = {
			x-paste = "xclip -sel clip -o";
			x-copy = "xclip -sel clip";
			exe = "result/bin/*";
			ls = "lsd";
			nix-pr = "/nix/var/nix/profiles/system";
			avg-core-temp = "cat /sys/class/thermal/thermal_zone*/temp | awk '{ sum += $1 } END { print sum / NR }'";
			latest-lecture-folder = "alacritty --working-directory ~/vimwiki/lectures/(ls ~/vimwiki/lectures -t | head -n 1)";

			"+x" = "chmod +x";
			a = "alacritty";
			ar = "xrandr --auto";
			b = "bat";
			c = "cat";
			co = "xclip -sel clip";
			d = "dirname";
			di = "disown";
			ch = "chown";
			e = "echo";
			f = "fish";
			g = "grep";
			gc = "git clone https://github.com/";
			k = "killall";
			lb = "lsblk";
			m = "mount";
			md = "mkdir";
			mf = "mkfifo";
			n = "nvim";
			ns = "nix-shell";
			nsf = "nix-shell --run fish";
			nch = "nix-channel";
			nsp = "nix-shell -p";
			npg = "nix-prefetch-git";
			nr = "nixos-rebuild";
			nrs = "nixos-rebuild switch";
			nrb = "nixos-rebuild boot";
			nrt = "nixos-rebuild test";
			p = "pkill";
			pa = "xclip -sel clip -o";
			r = "readlink";
			rb = "reboot";
			s = "sudo";
			sn = "shutdown now";
			snr = "sudo nixos-rebuild";
			snrs = "sudo nixos-rebuild switch";
			t = "trash";
			to = "touch";
			u = "umount";
			w = "which";
			x = "pkexec";
			xo = "xdg-open";
			xr = "xrandr";
			xnrs = "pkexec nixos-rebuild switch";
			xnrb = "pkexec nixos-rebuild boot";
			xnrt = "pkexec nixos-rebuild test";
		};
		functions = {
			project-new = {
				description = "Creates a new project in dump and link to current location";
				body = ''
					set project_path "${devDir}/.dump/projects/$argv[1]"
					if test -e $project_path
						echo This project name is taken
					else
						mkdir $project_path
						set link_path (pwd)
						ln -s $project_path $name
						cd $project_path
						"$link_path/.gen.fish" $link_path
					end
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
			#__informative_git_prompt = {
			#	description = "Provides git information";
			#	body = builtins.readFile ./functions/__informative_git_prompt.fish;
			#};
			del = {
				description = "Safer deletion";
				body = ''
					function del
						if test -d $argv[1]
							and not test -L $argv[1]
							rmdir $argv[1]
						else
							rm -i $argv[1]
						end
					end
				'';
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

			#gparted-run = {
			#	description = "Run gparted";
			#	body = ''
			#		xhost +local:
			#		gparted
			#	'';
			#};
			#kdenlive-run = {
			#	description = "Run kdenlive on Wayland";
			#	body = ''
			#		QT_QPA_PLATFORM=xcb kdenlive
			#	'';
			#};
			nspf = {
				description = "nix-shell -p ... --run fish";
				body = "nix-shell --run fish -I \"nixpkgs=$HOME/nixpkgs\" -p $argv";
			};
		};
	};
}
