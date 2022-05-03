{ pangoFont, gruvboxTheme }:
{ config, pkgs, lib, ...}:
{
	programs.mako = {
		# https://github.com/nix-community/home-manager/blob/master/modules/services/mako.nix
		enable = false;
		maxVisible = 5;
		sort = "+time";
		anchor = "bottom-right";
		font = pangoFont 10;
		backgroundColor = "#" + gruvboxTheme.bg + "CC";
		borderRadius = 2;
		borderColor = "#" + gruvboxTheme.yellow;
		defaultTimeout = 5000;
	};
}
