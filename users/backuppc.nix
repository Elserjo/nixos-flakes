{ config, ... }:

{
  users.users = {
    backuppc = {
      description = "User for BackupPC tasks";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfHGpvRrLTB85SF/OgXCK/XoyayrEz8gYv9M1aWUuvLuY8vYIZSYJsjUxAK9JaQ9ycNxpVnSJV1msrHS8Z/smUMexj2YURgdcZetpoht/Fy3Qg8kj5BDOehDfaAfAQJWiOUSkgMKFyG3ommVzOUOsgKobk0UP2+8cIKvB2Nnjfd5iTFDjZErML25oRS5ptyydspv/MmyDJ//yynVUFV4V/zmxSMyL6y5wxCAU9GjD+67G61R4cf6I9c1cmHrs5TLwZmUtIOBo3CzCuXak0dtQWL+7WXCheFhnJP6qRy7cBnHBmb5sZX7QJKeSQJ7P0ybBSH5J13nFcZ+8e6iYyXFKAo5W8Iaco/kYdaHpMn+2AeiO2iq1YCBUNgUN5H/pfkDrzfx3iNLAOZujGKYNtsyLX6OSW2I5qDSeRb1sqeFYTEMTSVMoyVlJ0Hle7Bxri8rTx+9aJVo7xAN3mdpyId9AzyneKHJTnTGxNbphLpWIfUimMW5Y0Vept21inhtBJE7s= root@S4.ASUS"
      ];
      isNormalUser = true;
      extraGroups = [ "shared" ];
    };
  };
  #I need ssh service only for this user
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };
}
