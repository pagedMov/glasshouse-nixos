{
	autoCmd = [
		{
			command = "FloatermNew --wintype=float --name=rangerterm --position=topleft --autoclose=2 --opener=edit --cwd=<buffer> --titleposition=left ranger<CR><CR>";
			event = [ "VimEnter" ];
			pattern = [ "*" ];
		}
	];
}
