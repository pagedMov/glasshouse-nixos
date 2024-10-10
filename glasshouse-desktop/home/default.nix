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
	 ++ [ (import ./scripts)     	  ]
	 ++ [ (import ./yazi.nix)         ]
	 ++ [ (import ./swaync/swaync.nix)]
	 ++ [ (import ./userpkgs.nix)     ]
	 ++ [ (import ./waybar) 	      ]
	 ++ [ (import ./eza.nix) 	      ]
	 ++ [ (import ./zsh/zshell.nix)   ];
}
