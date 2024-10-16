{ pkgs, inputs, ... }:

{
	home.persistence."/persist/home" = {
		directories = [
			".sysflake"
			".password-store"
			".local/share/keyrings"
			".local/share/direnv"
			".ssh"
			".gnupg"
			"Coding"
			"Videos"
			"Documents"
			"Music"
			"Downloads"
			"Misc"
			{
				directory = ".local/share/Steam";
				method = "symlink";
			}
		];
		files = [
			".zsh_history"
		];
		allowOther = true;
	};
}
