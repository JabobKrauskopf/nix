{
  pkgs,
  otherPkgs,
  ...
}:

{
  imports = [
    ./docker.nix
    ./python.nix
  ];

  environment.systemPackages =
    with pkgs;
    with otherPkgs;
    [
      nixpkgs-unstable.claude-code
      uv
    ];

  environment.sessionVariables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };
}
