{ inputs, ... }:

{
	imports = 
		[ (import ./btop.nix) 	      ]
	 ++ [ (import ./bat.nix) 	      ]
	 ++ [ (import ./cava.nix) 	      ]
	 ++ [ (import ./fuzzel.nix)       ]
	 ++ [ (import ./gtk.nix) 	      ]
	 ++ [ (import ./hyprland)         ]
	 ++ [ (import ./kitty.nix)        ]
	 ++ [ (import ./spicetify.nix)    ]
	 ++ [ (import ./starship.nix)     ]
	 ++ [ (import ./swaync/swaync.nix)]
	 ++ [ (import ./theme) 		      ]
	 ++ [ (import ./toilet) 	      ]
	 ++ [ (import ./userpkgs.nix)     ]
	 ++ [ (import ./waybar) 	      ]
	 ++ [ (import ./zshell.nix)       ];
}
