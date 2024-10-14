{ username, ... }:

let
	home = "/home/${username}";
in
{
	programs.password-store = {
		enable = true;
		settings = {
			PASSWORD_STORE_DIR = "${home}/.password-store";
		};
	};
}
