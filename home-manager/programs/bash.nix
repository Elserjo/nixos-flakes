{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    bashrc.Extra = ''
      export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"
      PS1='[\u@\h \W] \$ '
      alias df='df -h'
      alias mv='mv -iv'
      alias rm='rm -vi'
      alias se='sudoedit'
    '';
  };
}
