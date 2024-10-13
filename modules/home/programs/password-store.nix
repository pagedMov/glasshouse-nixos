{ ... }:

{
	programs.password-store = {
		enable = true;
		settings = {
			PASSWORD_STORE_DIR = "$XDG_DATA_HOME/.pass";
		};
	};
}
