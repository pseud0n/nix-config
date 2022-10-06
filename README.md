# nixos-config
Current configuration for x86_64 computer running Home Manager & NixOS 21.05 with dual boot.
This uses Openbox.

To use, install NixOS: https://nixos.org/manual/nixos/stable/index.html#sec-obtaining
To avoid `sudo` issues, I put my config in `~/nixos` and then did `ln -s ~/nixos /etc/nixos`
After, clone this repo & generate `hardware-configuration.nix` using `nixos-generate-config`.
Inside `configuration.nix`, there is specific configuration for Broadcom wifi, which can be deleted without problem.
# Configuration of laptop & Pi 4 using NixOS & Home Manager
