{
	description = "A flake for a clean Rust development environment";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: 
	let
		pkgs = import nixpkgs {
			inherit system;
			overlays = [
				(self: super: {
					inherit (super) nixvim zsh git;
				})
			];
		};
	in rec {
		devShell = pkgs.mkShell {
			name = "rust-dev-env";
			buildInputs = [
				pkgs.rustup        # Rust toolchain manager
				pkgs.cargo         # Cargo package manager
				pkgs.rustc         # Rust compiler
				pkgs.cargo-watch   # Automatically rebuilds Cargo project on change
				pkgs.clippy        # Linter for Rust
				pkgs.rustfmt       # Rust code formatting
				pkgs.pkg-config    # Needed for many Rust dependencies
				pkgs.openssl       # OpenSSL (common Rust dependency)
			];

			shellHook = ''
				echo "Rust dev environment initialized"
				rustup default stable
			'';
		};
	});
}
