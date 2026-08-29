{ inputs, lib, ...  }:

{
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            history.ignoreDups = true;

            initContent = ''
                EDITOR=vim

                con() {
                    local password_file=""
                    local user_name=""
                    local host_name="''${1}"

                    case "''${host_name}" in
                        holliday|fitting[4-9]|fitting1[0-2])
                            user_name="sheglov_s"
                            password_file="''${HOME}"/.ssh/password-own
                            ;;
                        *)
                            echo "Using default password..."
                            password_file="''${HOME}"/.ssh/password-common
                            user_name="root"
                            ;;
                    esac

                    if [[ ! -f "''${password_file}" ]]; then
                        echo "Password file is not exists: ''${password_file}"
                        return 1
                    fi

                    TERM=xterm-256color sshpass -f "''${password_file}" \
                        ssh "''${user_name}"@"''${host_name}"
                }
            '';
        };
    };
}
