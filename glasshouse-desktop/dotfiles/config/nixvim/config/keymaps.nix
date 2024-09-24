{
	keymaps = [
		{
			action = "<cmd>FloatermToggle shadeterm<CR>";
			key = "<F2>";
			mode = "n";
		}
		{
			action = "<cmd>FloatermNew --wintype=float --name=rangerterm --position=topleft --autoclose=2 --opener=edit --cwd=<buffer> --titleposition=left ranger<CR><CR>";
			key = "<F3>";
			mode = "n";
		}
		{
			action = "<cmd>FloatermToggle shadeterm<CR>";
			key = "<F2>";
			mode = "t";
		}
		{
			action = "<cmd>FloatermKill rangerterm<CR>";
			key = "<F3>";
			mode = "t";
		}

	];
}
