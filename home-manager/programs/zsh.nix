{ inputs, lib, ...  }:

{
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            history.ignoreDups = true;

            initContent = ''
                EDITOR=vim
            '';
        };
    };
}
