{ nur, self, inputs, username, system, ... }:




{
	imports = 
		[ (import ./programs/btop.nix) 	       ]
	 ++ [ (import ./programs/yazi.nix)         ]
	 ++ [ (import ./programs/kitty.nix)        ]
	 ++ [ (import ./programs/fuzzel.nix)       ]
	 ++ [ (import ./programs/eza.nix) 	       ]
	 ++ [ (import ./programs/cava.nix) 	       ]
	 ++ [ (import ./programs/bat.nix) 	       ]
	 ++ [ (import ./environment/gtk.nix) 	   ]
	 ++ [ (import ./environment/spicetify.nix) ]
	 ++ [ (import ./environment/starship.nix)  ]
	 ++ [ (import ./environment/userpkgs.nix)  ]
	 ++ [ (import ./environment/zshell.nix)    ]
	 ++ [ (import ./firefox/firefox.nix)       ]
	 ++ [ (import ./hyprland)                  ]
	 ++ [ (import ./scripts)     	           ]
	 ++ [ (import ./swaync/swaync.nix)         ]
	 ++ [ (import ./waybar) 	               ];
}
