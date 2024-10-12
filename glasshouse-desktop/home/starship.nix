{ lib, inputs, ... }:

{
	programs.starship = {
		enable = true;
		enableZshIntegration = false;
		settings = {
		# right_format = "";

			format = lib.concatStrings [
				"($username)(bold white)($cmd_duration)($character)$line_break"
				"($git_branch)($git_status)$line_break"
				"($directory)$line_break"
				"[   ](bold #89b4fa)"
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
				success_symbol = "[ -> ](bold green)";
				error_symbol = "[ -> ✗](bold red)";
# error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
			};

			cmd_duration = {
				format = "[ 󰔛 $duration]($style)";
				disabled = false;
				style = "bg:none fg:#f9e2af";
				show_notifications = false;
				min_time_to_notify = 60000;
			};
			git_branch = {
				format = "on [$symbol$branch](bold purple)";  
				symbol = " ";  
				truncation_length = 15;
				style = "bold purple";
			};

			palette = "catppuccin_mocha";
		} // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml");
	};
}

