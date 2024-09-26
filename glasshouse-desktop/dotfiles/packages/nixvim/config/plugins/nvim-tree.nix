{
	plugins.nvim-tree = { 
			enable = true; 
			hijackUnnamedBufferWhenOpening = true;
			openOnSetup = true;
			onAttach = { __raw = "function(bufnr) local api = require('nvim-tree.api') vim.keymap.set('n', 'b', api.node.open.preview, opts('Open Preview')) end"; };
			view = { 
				side = "right";	
				centralizeSelection = true;
				number = true;
				relativenumber = true;
				width = 40;
			};
	};
}
