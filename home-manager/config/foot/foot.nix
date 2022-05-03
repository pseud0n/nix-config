{ gruvboxTheme }:
{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
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
}
