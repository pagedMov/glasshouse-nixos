{ pkgs }:

{
	extraPlugins = [
		(pkgs.vimUtils.buildVimPlugin { # vimwiki
			name = "vimwiki";
			src = pkgs.fetchFromGithub {
				owner = "vimwiki";
				repo = "vimwiki";
				rev = "dev";
				hash = "705ad1e0dded0e3b7ff5fac78547ab67c9d39bdf";
			};
		})
	];
}
