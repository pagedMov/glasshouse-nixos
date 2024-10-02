{
	autoCmd = [
		{
			command = "FloatermNew --wintype=float --name=shadeterm --position=topright --autoclose=0 --silent --cwd=<buffer> --titleposition=left zsh";
			event = [ "VimEnter" ];
			pattern = [ "*" ];
		}
		{
			command = "silent! mkview";
			event = [ "BufWinLeave" ];
			pattern = [ "*" ];
		}
		{
			command = "silent! !aplay ~/sound/sys/cd.wav > /dev/null 2>&1 &";
			event = [ "BufWinLeave" ];
			pattern = [ "*" ];
		}
		{
			command = "silent! loadview";
			event = [ "BufWinEnter" ];
			pattern = [ "*" ];
		}
	];
}
