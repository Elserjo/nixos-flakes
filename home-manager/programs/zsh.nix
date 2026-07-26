{ inputs, lib, ...  }:

{
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
        };
    };
}
