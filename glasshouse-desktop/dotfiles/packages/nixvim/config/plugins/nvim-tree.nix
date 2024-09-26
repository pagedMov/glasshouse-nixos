{
	plugins.nvim-tree = { 
			enable = true; 
			hijackUnnamedBufferWhenOpening = true;
			openOnSetup = true;
			onAttach = ''
local api = require('nvim-tree.api')
vim.keymap.set('n', 'b', api.node.open.preview, opts('Open Preview'))
			'';
			view = { 
				side = "right";	
				centralizeSelection = true;
				number = true;
				relativenumber = true;
				width = 40;
			};
	};
}
