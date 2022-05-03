{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
	xdg.configFile."lf/lfrc".text = builtins.readFile ./lfrc;
}
