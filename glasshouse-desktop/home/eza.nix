{ ... }:

{
	programs.eza = {
		enable = true;
		enableZshIntegration = true;
		extraOptions = [ "-1" "-h" "--group-directories-first" ];
		icons = true;
		git = true;
	};
}
