{ nur, username, ... }:

{
	programs.firefox = {
		enable = true;
		profiles.${username} = {
			name = "${username}";
			isDefault = true;
			bookmarks = [
				{ name = "NixOS Options";
					url = "https://search.nixos.org/options";
				}
				{ name = "Home Manager Options";
					url = "https://home-manager-options.extranix.com/";
				}
				{ name = "Nixvim Docs";
					url = "https://nix-community.github.io/nixvim/";
				}
				{ name = "Rust Manual";
					url = "https://doc.rust-lang.org/book/ch01-03-hello-cargo.html";
				}
				{ name = "ChatGPT";
					url = "https://chatgpt.com/";
				}
				{ name = "DataAnnotation";
					url = "https://app.dataannotation.tech/users/sign_in";
				}
				{ name = "Nerd Fonts Cheatsheet";
					url = "https://www.nerdfonts.com/cheat-sheet";
				}
			];
			extensions = with nur.repos.rycee.firefox-addons; [
				darkreader
				adnauseam
				cookie-autodelete
				disconnect
				vimium
				firenvim
				privacy-badger
			];
			settings = {
				"extensions.autoDisableScopes" = 0;
				"browser.startup.homepage" = "https://nixos.org";
			};
		};
	};
}
