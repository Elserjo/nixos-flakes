{ config, ... }:

{
  users.users = {
    backuppc = {
      description = "User for BackupPC tasks";
      openssh.authorizedKeys.keys = [
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDwhlpn4qDLQzFQZbP3iUQIbZHAxdpaQquOYmD0qXVDoTRTrAWP8ICVQ2C6K5ytCZRyBfVUqjxfnOw9IXxd3CNnw7ATQxojyaZ0jeBy5mVmLLb+erdthedh3nRnMsvXwxhv+5slm7VqhdPwH+BGAoLYz/CFRPY6EKwKjNMBDcMiARsN2okCvMSg/feaiWrjVI1xRs6Fz+lG0NhJnqDlEBLYWxMJ9PBp1tvV1BmWvVT6YuBsG93v5HH7dqXTDbQSBZGx5Uy4UGt1wDpiiEFmCUj7vB06Bh9e5KKSrEtxfTVGaKUUs4lJu1H82mpZm3Tq+NmqnDUKF8mQRM9+o0z0/8XheXv2kqA33nsiZi+6hFw78j1ecsBFiTJ2BmsQJQSezP/rKVfwyxRn0CU8gPS+PUM+lCJH5pP7b6k5kW6BGLKs8VuPuVkZFDiXfi+d4gaIHUD+0Zc3dv8tiDBvbQudyARYXnWCkED3kzKRQwW8dTv3GaA+2K5ilWCogCJmpTD6qqU= as689@P4"
      ];
      isNormalUser = true;
    };
  };

  #Additional group for shared folders
  users.groups = { shared = { members = [ "serg" "backuppc" ]; }; };

  #I need ssh service only for this user
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };
}
