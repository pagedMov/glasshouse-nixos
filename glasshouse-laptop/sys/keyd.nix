{ pkgs, ... }:

{
	services.keyd = {
		enable = true;
		keyboards = {
			builtin = {
				ids = [ "*" ];
				settings = {
					main = {
						capslock = "esc";
					};
				};
			};
		};
	};
}
