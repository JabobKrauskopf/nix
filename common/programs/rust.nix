{
  pkgs,
  otherPkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    with otherPkgs;
    [
      nixpkgs-unstable.rustup
      nixpkgs-unstable.cargo-hack
      gcc # Rust requires the linker "cc"
      openssl
      openssl.dev # Some Rust crates such as "openssl-sys" require OpenSSL and pkg-config to compile (see also the PKG_CONFIG_PATH environment variable below)
      pkg-config
    ];

  environment.variables = {
    # This is needed in combination with the "pkg-config" and "openssl.dev" package to make some Rust crates compile (such as "openssl-sys")
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
}
