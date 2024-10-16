{pkgs, ...}: {
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "tokyo-night";
      theme_background = false;
      update_ms = 500;
      vim_keys = true;
      proc_tree = true;
      temp_scale = "fahrenheit";
      disks_filter = "exclude=/boot";
      show_swap = false;
      swap_disk = false;
    };
  };

  home.packages = with pkgs; [nvtopPackages.intel];
}
