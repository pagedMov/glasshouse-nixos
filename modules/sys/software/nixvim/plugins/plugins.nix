{
  programs.nixvim = {
    plugins = {
      nvim-surround.enable = true;
      indent-blankline.enable = true;
      treesitter.enable = true;
      lastplace.enable = true;
      markdown-preview.enable = true;
      gitsigns.enable = true;
      web-devicons.enable = true;
      endwise.enable = true;
      marks.enable = true;
      trouble.enable = true;
      floaterm.enable = true;
      fugitive.enable = true;
      rustaceanvim.enable = true;
      firenvim.enable = true;
      dap = {
        enable = true;
        extensions.dap-ui.enable = true;
      };
    };
  };
}
