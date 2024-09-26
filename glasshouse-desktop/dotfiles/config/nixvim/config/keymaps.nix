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
		{
			action = "<C-w>h";  # Move to the left split (Ctrl+W, then H)
				key = "H";          # Shift+H key binding
				mode = "n";         # Normal mode
		}
		{
			action = "<C-w>j";  # Move to the bottom split (Ctrl+W, then J)
				key = "J";
			mode = "n";
		}
		{
			action = "<C-w>k";  # Move to the top split (Ctrl+W, then K)
				key = "K";
			mode = "n";
		}
		{
			action = "<C-w>l";  # Move to the right split (Ctrl+W, then L)
				key = "L";
			mode = "n";
		}
	];
}
