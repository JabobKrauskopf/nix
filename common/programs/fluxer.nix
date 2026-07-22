{ pkgs, ... }:

let
  pname = "fluxer-canary";
  version = "2026.602.31138";

  src = pkgs.fetchurl {
    url = "https://api.canary.fluxer.app/dl/desktop/canary/linux/x64/${version}/appimage";
    hash = "sha256-d4FAWwrWyoyp7lo8X+nIe+Dd6Z8rDThyK1wU00f7rjY=";
    name = "Fluxer-Canary-${version}.AppImage";
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };

  fluxer-canary = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/fluxer-canary.desktop $out/share/applications/fluxer-canary.desktop
      install -Dm444 ${appimageContents}/fluxer-canary.png $out/share/icons/hicolor/512x512/apps/fluxer-canary.png
      substituteInPlace $out/share/applications/fluxer-canary.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in
{
  environment.systemPackages = [ fluxer-canary ];
}
