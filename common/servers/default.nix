{ defaultUser, ... }:

{
  imports = [
    ../default.nix
    ../programs/docker.nix
  ];

  users.users.${defaultUser}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHa42I8eXyoYPxrxkH78JrBLwTxmRRTKcqngSJlslln"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkCxNu7nu3XOHWjm/DpuBN1Ttp1uSKj9nXF/TEpiDGF"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4qr9sHVc0/WXaNHDHcWt7skwv3nWn7GVQiu84iIC8n"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9E2maPZO8DN7jGtW6/m2Djw4zHoTyZmowJBSvm3/nI"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDd5rD/DawdTv/W1tB+A5upZl3b18PpRbDaUKPhVjorl"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1k4B+cwehZLQNaOG8+H1epIqnBCB4bMPc/kbz2Z1su"
  ];

  services.openssh.enable = true;

  programs.nix-ld.enable = true;
}
