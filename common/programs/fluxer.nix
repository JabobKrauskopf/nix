{ pkgs, ... }:

let
  pname = "fluxer-canary";
  version = "2026.919.185602";

  src = pkgs.fetchurl {
    url = "https://api.canary.fluxer.app/dl/desktop/canary/linux/x64/${version}/appimage";
    hash = "sha256-+ooipZm0Wi+B3hppWvWdjI4P6EqspAdnLdz5wXSWjZ8=";
    name = "Fluxer-Canary-${version}.AppImage";
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };

  fluxer-canary = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/fluxer-canary.desktop $out/share/applications/fluxer-canary.desktop
      install -Dm444 ${appimageContents}/fluxer-canary.png $out/share/icons/hicolor/512x512/apps/fluxer-canary.png
      substituteInPlace $out/share/applications/fluxer-canary.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname} --fluxer-app-url=https://chat.jaale.de'
    '';
  };
in
{
  environment.systemPackages = [ fluxer-canary ];
}
