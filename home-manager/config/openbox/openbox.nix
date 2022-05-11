{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
	xdg.configFile."openbox/menu.xml".text = builtins.readFile ./menu.xml;
	xdg.configFile."openbox/rc.xml".text = builtins.readFile ./rc.xml;
	xdg.configFile."openbox/autostart".text = builtins.readFile ./autostart;
}
