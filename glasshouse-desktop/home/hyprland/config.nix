{... }:

{
	wayland.windowManager.hyprland = {
		settings = {
			exec-once = [
				"waybar &"
				"swaync &"
				"wl-paste --watch cliphist store &"
				"wl-clip-persist --clipboard both"
				"swaybg -m fill -i $(find ~/Pictures/Wallpapers/ -maxdepth 1 -type f) &"
				"systemctl --user import-environment &"
				"hash dbus-update-activation-environment 2>/dev/null &"
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
				"aplay /home/pagedmov/sound/sys/login.wav &"
			];

			input = {
				kb_layout = "us";
				follow_mouse = 1;
				accel_profile = "flat";
				force_no_accel = 1;
				sensitivity = 0;
			};

			general = {
				"$mainMod" = "SUPER";
				layout = "dwindle";
				gaps_in = 0;
				gaps_out = 0;
				border_size = 2;
				"col.active_border" = "rgb(cba6f7) rgb(94e2d5) 45deg";
				"col.inactive_border" = "0x00000000";
				border_part_of_window = false;
				no_border_on_floating = false;
			};
			misc = {
				disable_autoreload = true;
				disable_hyprland_logo = true;
				always_follow_on_dnd = true;
				layers_hog_keyboard_focus = true;
				animate_manual_resizes = false;
				enable_swallow = true;
				focus_on_activate = true;
			};

			dwindle = {
				no_gaps_when_only = true;
				force_split = 0;
				special_scale_factor = 1.0;
				split_width_multiplier = 1.0;
				use_active_for_splits = true;
				pseudotile = "yes";
				preserve_split = "yes";
			};

			master = {
				new_status = "master";
				special_scale_factor = 1;
				no_gaps_when_only = false;
			};

			decoration = {
				rounding = 0;
				# active_opacity = 0.90;
				# inactive_opacity = 0.90;
				# fullscreen_opacity = 1.0;

				blur = {
					enabled = true;
					size = 1;
					passes = 1;
					# size = 4;
					# passes = 2;
					brightness = 1;
					contrast = 1.400;
					ignore_opacity = true;
					noise = 0;
					new_optimizations = true;
					xray = true;
				};

				drop_shadow = true;

				shadow_ignore_window = true;
				shadow_offset = "0 2";
				shadow_range = 20;
				shadow_render_power = 3;
				"col.shadow" = "rgba(00000055)";
			};

			animations = {
				enabled = true;

				bezier = [
					"fluent_decel, 0, 0.2, 0.4, 1"
						"easeOutCirc, 0, 0.55, 0.45, 1"
						"easeOutCubic, 0.33, 1, 0.68, 1"
						"easeinoutsine, 0.37, 0, 0.63, 1"
				];

				animation = [
				# Windows
					"windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
						"windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
						"windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

						# Fade
						"fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
						"fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
						"fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
						"fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
						"fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
						"border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
						"borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
						"workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
				];

				bind = [
					"$mainMod, up, exec, pactl set-sink-volume @default_sink@ +10%"
					"$mainMod, down, exec, pactl set-sink-volume @default_sink@ -10%"
					"$mainMod, print, exec, grimblast copy area"
					"$mainMod, a, exec, $browser"
					"$mainMod, q, exec, $terminal --title Kitty"
					"$mainMod, d, exec, /home/pagedmov/coding/scripts/switchmon.sh"
					"$mainMod, c, killactive,"
					"$mainMod shift, q, exit,"
					"$mainMod, m, exec, $menu"
					"$mainMod, e, exec, $filemanager"
					"$mainMod, r, exec, neovide"
					"$mainMod, p, pseudo, # dwindle"
					"$mainMod, b, togglesplit, # dwindle"
					"$mainMod, f, togglefloating"
					"$mainMod, g, fullscreen"
					"$mainMod, home, exec, /home/pagedmov/scripts/home.sh"
					"$mainMod, h, movefocus, l"
					"$mainMod, l, movefocus, r"
					"$mainMod, k, movefocus, u"
					"$mainMod, j, movefocus, d"
					"$mainMod, 1, exec, hyprctl 'dispatch workspace 1'"
					"$mainMod, 2, exec, hyprctl 'dispatch workspace 2'"
					"$mainMod, 3, exec, hyprctl 'dispatch workspace 3'"
					"$mainMod, 4, exec, hyprctl 'dispatch workspace 4'"
					"$mainMod, 5, exec, hyprctl 'dispatch workspace 5'"
					"$mainMod, 6, exec, hyprctl 'dispatch workspace 6'"
					"$mainMod, 7, exec, hyprctl 'dispatch workspace 7'"
					"$mainMod, 8, exec, hyprctl 'dispatch workspace 8'"
					"$mainMod, 9, exec, hyprctl 'dispatch workspace 9'"
					"$mainMod, 0, exec, hyprctl 'dispatch workspace 10'"
					"$mainMod alt, g, togglegroup"
					"$mainMod alt, h, changegroupactive, b"
					"$mainMod alt, l, changegroupactive, f"
					"$mainMod shift, h, movewindoworgroup, l"
					"$mainMod shift, l, movewindoworgroup, r"
					"$mainMod shift, k, movewindoworgroup, u"
					"$mainMod shift, j, movewindoworgroup, d"
					"$mainMod shift, 1, movetoworkspace, 1"
					"$mainMod shift, 2, movetoworkspace, 2"
					"$mainMod shift, 3, movetoworkspace, 3"
					"$mainMod shift, 4, movetoworkspace, 4"
					"$mainMod shift, 5, movetoworkspace, 5"
					"$mainMod shift, 6, movetoworkspace, 6"
					"$mainMod shift, 7, movetoworkspace, 7"
					"$mainMod shift, 8, movetoworkspace, 8"
					"$mainMod shift, 9, movetoworkspace, 9"
					"$mainMod shift, 0, movetoworkspace, 10"
					"$mainMod, s, togglespecialworkspace, magic"
					"$mainMod shift, s, movetoworkspace, special:magic"
					"alt, grave, togglespecialworkspace, console"
					"$mainMod, mouse_down, workspace, e+1"
					"$mainMod, mouse_up, workspace, e-1"
					"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
				];
			};
		};
	};
}
