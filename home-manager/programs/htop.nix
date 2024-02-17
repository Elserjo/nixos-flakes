{ pkgs, config, lib, ... }:

{
  programs.htop.enable = true;

  programs.htop.settings = {
    fields = with config.lib.htop.fields; [
      PID
      USER
      PERCENT_CPU
      PERCENT_MEM
      TIME
      COMM
    ];
    color_scheme = 1;
    show_program_path = false;
    sort_key = config.lib.htop.fields.PERCENT_CPU;
    hide_kernel_threads = true;
    hide_threads = true;
    hide_userland_threads = true;
    highlight_base_name = true;
    highlight_megabytes = true;
    cpu_count_from_zero = false;
  } // (with config.lib.htop;
    leftMeters [ (bar "AllCPUs2") (bar "Memory") (bar "Swap") ])
    // (with config.lib.htop;
      rightMeters [ (text "Tasks") (text "LoadAverage") (text "Uptime") ]);
}
