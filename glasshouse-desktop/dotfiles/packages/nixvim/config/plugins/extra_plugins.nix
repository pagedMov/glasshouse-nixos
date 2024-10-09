{ lib, pkgs, ... }:

{
	extraPlugins = [
		(pkgs.vimUtils.buildVimPlugin { # vimwiki
			name = "vimwiki";
			src = pkgs.fetchFromGitHub {
				owner = "vimwiki";
				repo = "vimwiki";
				rev = "705ad1e0dded0e3b7ff5fac78547ab67c9d39bdf";
				hash = "sha256-Upx29rIPwW/e7Lkmf0PNOpIACnAXIzlkfa6V1p2nYHM=";
			};
		})
	];
}
