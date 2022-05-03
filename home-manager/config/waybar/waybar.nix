{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
	programs.waybar.enable = true;
	xdg.configFile."waybar/config".text = readConfig /waybar/config;
	xdg.configFile."waybar/style.css".text = readConfig /waybar/style.css;
	xdg.configFile."waybar/colours.css".text = readConfig /waybar/colours.css;
}
