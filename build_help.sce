help_lang_dir = get_absolute_file_path("build_help.sce");
TOOLBOX_TITLE = "Signal Processing"
tbx_build_help(TOOLBOX_TITLE,get_absolute_file_path("build_help.sce"));
ok =
add_help_chapter('itpp_pam_mod',get_absolute_file_path("build_help.sce"));
clear help_lang_dir;
