{ inputs, ... }:

{
	imports = 
		[ (import ./btop.nix) 	   ]
	 ++ [ (import ./bat.nix) 	   ]
	 ++ [ (import ./cava.nix) 	   ]
	 ++ [ (import ./fuzzel.nix)    ]
	 ++ [ (import ./gtk.nix) 	   ]
	 ++ [ (import ./hyprland)      ]
	 ++ [ (import ./kitty.nix)     ]
	 ++ [ (import ./nixvim) 	   ]
	 ++ [ (import ./scripts) 	   ]
	 ++ [ (import ./spicetify.nix) ]
	 ++ [ (import ./starship.nix)  ]
	 ++ [ (import ./swaync) 	   ]
	 ++ [ (import ./theme) 		   ]
	 ++ [ (import ./toilet) 	   ]
	 ++ [ (import ./userpkgs.nix)  ]
	 ++ [ (import ./waybar) 	   ]
	 ++ [ (import ./zshell.nix)    ];
}
