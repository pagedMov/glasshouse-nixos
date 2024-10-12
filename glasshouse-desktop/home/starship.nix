{ lib, inputs, ... }:

{
	programs.starship = {
		enable = true;
		enableZshIntegration = false;
		settings = {
			add_newline = true;
		# right_format = "";

			format = lib.concatStrings [
				"($username)(bold white)($cmd_duration)($character)"
				"($git_branch)($git_status)"
				"($directory)"
				"$line_break[   ](bold #89b4fa)"
			];

			
			username = {
				show_always = true;
				style_user = "bold white";
				format = "[$user]($style)";
			};
			directory = {
				format = "\n[$path](bold cyan)[/](bold green) ";
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
				format = "\non [$symbol$branch](bold purple)";  
				symbol = " ";  
				truncation_length = 15;
				style = "bold purple";
			};

			palette = "catppuccin_mocha";
		} // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml");
	};
}

