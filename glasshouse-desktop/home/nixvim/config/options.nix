{
		colorschemes = {
			catppuccin = {
				enable = true;
				settings.flavour = "mocha";
			};
			kanagawa = {
				enable = false;
			};
		};
		
		diagnostics.signs = false;
		extraConfigLua = ''
			if vim.g.started_by_firenvim == true then
				vim.o.laststatus = 0
			end
			if vim.g.neovide then
				vim.g.neovide_refresh_rate = 144
				vim.g.neovide_cursor_vfx_mode = "sonicboom"
				vim.g.neovide_cursor_animate_in_insert_mode = false
			end

			vim.opt.number = true
			vim.opt.relativenumber = true
			vim.opt.hlsearch = true
			vim.opt.incsearch = true
			vim.opt.shiftwidth = 4
			vim.opt.tabstop = 4
			vim.opt.termguicolors = true
			vim.opt.ruler = true
			vim.opt.scrolloff = 6
			vim.opt.undofile = true
			vim.opt.foldmethod = "manual"
			vim.opt.wrap = true
			vim.opt.linebreak = true
			vim.opt.textwidth = 135
			vim.opt.breakat = " \t!@*-+;:,./?"

			vim.g.mapleader = "!"
		'';
}
