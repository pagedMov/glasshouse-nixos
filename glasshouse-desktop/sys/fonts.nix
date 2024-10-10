{ pkgs, ... }:

{
	fonts.packages = with pkgs; [ 
		times-newer-roman
		nerdfonts 
		jetbrains-mono 
	];
}
