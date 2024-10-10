{ lib, inputs, ... }:

{
	programs.starship = {
		enable = true;

		enableBashIntegration = true;
		enableZshIntegration = true;
		enableNushellIntegration = true;

		settings = {
# right_format = "$cmd_duration";

			format = lib.concatStrings [
			"($username)(bold white)"
			"($directory)"
			];

			
			username = {
				show_always = true;
				style_user = "bold white";
				format = "[$user]($style)";
			};
			directory = {
				format = "[$path](bold cyan)[/](bold green) ";
				style = "bold #b4befe";
			};

			character = {
				success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
				error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
# error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
			};

			cmd_duration = {
				format = "[󰔛 $duration]($style)";
				disabled = false;
				style = "bg:none fg:#f9e2af";
				show_notifications = false;
				min_time_to_notify = 60000;
			};        

			palette = "catppuccin_mocha";
		} // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml");
	};
}

