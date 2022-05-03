{ config, pkgs, lib, ... }:
{
	programs.git = {
		enable = true;
		userName = "pseud0n";
		userEmail = "pseud0n@users.noreply.github.com";
        # SSH key stored locally
	};
}
