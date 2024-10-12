{ self, pkgs }:


pkgs.writeShellScriptBin "crs" (''
#!/run/current-system/sw/bin/bash

cargo test && \
cargo run
	'')
