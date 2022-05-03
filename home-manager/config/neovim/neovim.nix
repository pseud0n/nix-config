{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
{
programs.neovim = {
		enable = true;
		vimAlias = true;
		withPython3 = true;
		extraConfig = builtins.readFile ./init.vim;
		plugins = let
			shades-of-purple = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
				pname = "shades-of-purple.vim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "Rigellute";
					repo = pname;
					rev = "e806d38190a6a2e8b9244824c2953d6567f141f3";
					sha256 = "1n2g1chmyzcwr3zr6gwfg1yc201awbdsfrfha3kpj8b50m5808ca";
				};
			};
			vim-purpura = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
				pname = "vim-purpura";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "yassinebridi";
					repo = pname;
					rev = "2398344cb16af941a9057e6b0cf4247ce1abb5de";
					sha256 = "0b1x2537x6p7psmb932fbhj3f14jjb92ccmand99kkngng4rq5ia";
				};
			};
			mathematic-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "mathematic-vim";
				version = "2.60";
				src = pkgs.fetchFromGitHub {
					owner = "gu-fan";
					repo = "mathematic.vim";
					rev = "e57ec0d767fee83f95994b1a8d5cc82395198a49";
					sha256 = "02w05bmzq5f6ry8b0kw5mkx4rnqwampjn9lx9jcagw53h4jmir0p";
				};
			};
			ctrlsf-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "ctrlsf-vim";
				version = "2.60";
				src = pkgs.fetchFromGitHub {
					owner = "dyng";
					repo = "ctrlsf.vim";
					rev = "253689525fddfcb78731bac2d5125b9579bfffb0";
					sha256 = "1xpff867cj1wyqd4hs7v12p7lsmrihmav2z46452q59f6zby5dp4";
				};
			};
#			vim-lf = pkgs.vimUtils.buildVimPluginFrom2Nix {
##				pname = "vim-lf";
##				src = pkgs.fetchFromGitHub {
##					owner = "khadegd";
##					repo = "vim-lf";
##					rev = "47de9abbc79a7c0a124f08054add0e2cedb90d89";
##					sha256 = "1syqrdzld616zbwixb9kc2kkr3bbc5c9dzmzffdjbyy60i0ynqys";
##				};
#				pname = "vim-lf";
#				version = "1.0";
#				src = pkgs.fetchFromGitHub {
#					owner = "longkey1";
#					repo = "vim-lf";
#					rev = "558634097fe02abd025100158c20277618b8bab2";
#					sha256 = "06f3lz4dkslnhysl0jcykm4b2pnkazjjpafnxlhz4qsrf21jqkfm";
#				};
#			};
			vim-maximizer = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "vim-maximizer";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "szw";
					repo = "vim-maximizer";
					rev = "2e54952fe91e140a2e69f35f22131219fcd9c5f1";
					sha256 = "031brldzxhcs98xpc3sr0m2yb99xq0z5yrwdlp8i5fqdgqrdqlzr";
				};
			};
			switch-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "switch-vim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "andrewradev";
					repo = "switch.vim";
					rev = "900c5d3ee79b1771c5e07bf7290068ea35881756";
					sha256 = "03fabz2xj69mwb52m3a1y9hlc0v62d0c2ysk7jjznx4mkq303cfm";
				};
			};
			lean-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "lean-nvim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "Julian";
					repo = "lean.nvim";
					rev = "74a222956b4f8db47ac8e3f5a48225c9afa7b6eb";
					sha256 = "19czdjy01xph8k61gclf5fqryfmml1i6vxgjjlczzhnvc763n4wq";
				};
				dependencies = with vimPlugins; [
					switch-vim
					nvim-lspconfig
					plenary-nvim
				];
			};
			zen-mode-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "zen-mode-nvim";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "folke";
					repo = "zen-mode.nvim";
					rev = "935a58307b64ce071689ba8ee915af5b9cdfe70c";
					sha256 = "09s7jn48nszha8j4r9r52qacc3gvhxka43am5g1wzlqxqcvns9fp";
				};
			};
			vim-repl = pkgs.vimUtils.buildVimPluginFrom2Nix {
				pname = "vim-repl";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "sillybun";
					repo = "vim-repl";
					rev = "22a8c5518b9c08b69ad531cef4ba6ec953b5154a";
					sha256 = "0rwc2pvk0jd2q0vk0kzlll5vvabjfc6ci9sfh21j3s072zvjvk4y";
				};
			};
			in
			with pkgs.vimPlugins; [
				# Aesthetics
				gruvbox # Nice colour scheme
				iceberg-vim # Dark blue colour scheme
				shades-of-purple
				vim-colorschemes
				awesome-vim-colorschemes
				vim-purpura
				vim-airline # Line at bottom of screen
				vim-airline-themes

				#nvim-treesitter # Better syntax hightlighting

				#vim-bufferline
        	    #nvim-bufferline-lua
				#barbar-nvim # Better tabs
				nvim-web-devicons

				vim-smoothie # Smooth scrolling

				# Language support
				nvim-lspconfig

				# Nix
				vim-nix

				# Fish
				vim-fish

				# i3
                i3config-vim

				# Rust
				rust-vim
				coc-rls

				# Clojure
				#tslime-vim
				vim-fireplace
				vim-salve
				vim-clojure-static
				vim-clojure-highlight
				vim-parinfer

				# Lean
				lean-nvim

				# MD
				vim-markdown
				markdown-preview-nvim

				# Haskell
				haskell-vim
				ghcmod-vim # Types inline

				coc-nvim

				# Python
				coc-pyright

				# C++
				coc-clangd

				coc-css

				coc-html

				coc-tsserver

				coc-json

				coc-cmake

				coc-java

				#vim-javacomplete2

				#ale
				#deoplete-nvim

				# Utilities
				suda-vim # sudo, but without launching Vim with sudo
				vim-maximizer # makes window fill screen
				zen-mode-nvim
				auto-pairs # Pairs, adds spaces, newline support
				nvim-colorizer-lua # Highlights colour codes in cod
				vimsence # Discord rich presence
				vim-hoogle # Hoogle search within Vim
				emmet-vim # generate HTML (like zen coding)
				nvim-compe # Completion
				#tagbar
				#ultisnips
				coc-snippets
				vim-sexp
				vim-sexp-mappings-for-regular-people
				rainbow
				vim-dispatch

				vimwiki # note-taking
				taskwiki

				mathematic-vim # For extra maths symbols
				vim-highlightedyank # Shows what's copied

				# Movement
				vim-sneak
				ctrlp-vim
				telescope-nvim
				ctrlsf-vim
				vim-floaterm
				lf-vim
				#vim-lf
				fzf-vim

				# Git
				vim-signify
				vim-fugitive
				vim-rhubarb
				vim-gitbranch

				# Misc
				plenary-nvim
			];
			extraPackages = with pkgs; [
				(python3.withPackages (ps: with ps; [
					pynvim
					tasklib
				]))
				nodejs
			];
			extraPython3Packages = (ps: with ps; [
				pynvim
				tasklib
				jedi
			]);
       };
}
