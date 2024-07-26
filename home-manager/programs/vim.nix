{ lib, ... }: {

  home.file.".config/vim/vimrc" = {
    text = ''
      set tabstop=4
      set shiftwidth=4
      set smarttab
      set expandtab
      set smartindent

      syntax on
      filetype plugin on'';
  };

}
