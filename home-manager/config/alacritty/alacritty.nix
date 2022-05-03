{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
	programs.alacritty.enable = true;
	xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./themes/shades-of-purple.yml;
}
