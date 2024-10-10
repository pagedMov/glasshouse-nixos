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
					"$mainmod, up, exec, pactl set-sink-volume @default_sink@ +10%"
					"$mainmod, down, exec, pactl set-sink-volume @default_sink@ -10%"
					"$mainmod, print, exec, grimblast copy area"
					"$mainmod, a, exec, $browser"
					"$mainmod, q, exec, $terminal --title Kitty"
					"$mainmod, d, exec, /home/pagedmov/coding/scripts/switchmon.sh"
					"$mainmod, c, killactive,"
					"$mainmod shift, q, exit,"
					"$mainmod, m, exec, $menu"
					"$mainmod, e, exec, $filemanager"
					"$mainmod, r, exec, neovide"
					"$mainmod, p, pseudo, # dwindle"
					"$mainmod, b, togglesplit, # dwindle"
					"$mainmod, f, togglefloating"
					"$mainmod, g, fullscreen"
					"$mainmod, home, exec, /home/pagedmov/scripts/home.sh"
					"$mainmod, h, movefocus, l"
					"$mainmod, l, movefocus, r"
					"$mainmod, k, movefocus, u"
					"$mainmod, j, movefocus, d"
					"$mainmod, 1, exec, hyprctl 'dispatch workspace 1'"
					"$mainmod, 2, exec, hyprctl 'dispatch workspace 2'"
					"$mainmod, 3, exec, hyprctl 'dispatch workspace 3'"
					"$mainmod, 4, exec, hyprctl 'dispatch workspace 4'"
					"$mainmod, 5, exec, hyprctl 'dispatch workspace 5'"
					"$mainmod, 6, exec, hyprctl 'dispatch workspace 6'"
					"$mainmod, 7, exec, hyprctl 'dispatch workspace 7'"
					"$mainmod, 8, exec, hyprctl 'dispatch workspace 8'"
					"$mainmod, 9, exec, hyprctl 'dispatch workspace 9'"
					"$mainmod, 0, exec, hyprctl 'dispatch workspace 10'"
					"$mainmod alt, g, togglegroup"
					"$mainmod alt, h, changegroupactive, b"
					"$mainmod alt, l, changegroupactive, f"
					"$mainmod shift, h, movewindoworgroup, l"
					"$mainmod shift, l, movewindoworgroup, r"
					"$mainmod shift, k, movewindoworgroup, u"
					"$mainmod shift, j, movewindoworgroup, d"
					"$mainmod shift, 1, movetoworkspace, 1"
					"$mainmod shift, 2, movetoworkspace, 2"
					"$mainmod shift, 3, movetoworkspace, 3"
					"$mainmod shift, 4, movetoworkspace, 4"
					"$mainmod shift, 5, movetoworkspace, 5"
					"$mainmod shift, 6, movetoworkspace, 6"
					"$mainmod shift, 7, movetoworkspace, 7"
					"$mainmod shift, 8, movetoworkspace, 8"
					"$mainmod shift, 9, movetoworkspace, 9"
					"$mainmod shift, 0, movetoworkspace, 10"
					"$mainmod, s, togglespecialworkspace, magic"
					"$mainmod shift, s, movetoworkspace, special:magic"
					"alt, grave, togglespecialworkspace, console"
					"$mainmod, mouse_down, workspace, e+1"
					"$mainmod, mouse_up, workspace, e-1"
					"$mainmod, mouse:272, movewindow"
					"$mainmod, mouse:273, resizewindow"
				];
			};
		};
	};
}
