{ pkgs, ... }:

let
  pname = "bambu-studio";
  version = "02.08.02.61";

  src = pkgs.fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu24.04-v${version}-20260820225108.AppImage";
    hash = "sha256-1QGxA/rFQkUT7A6Na8FF+zBxneLH2U1zINcjdAyBp/0=";
    name = "BambuStudio-${version}.AppImage";
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };

  bambu-studio = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    # The AppImage bundles almost none of its GUI stack, so provide the libs it
    # dlopen/links at runtime. libwebkit2gtk-4.1 is the one that stops it from
    # even starting; the rest cover the GTK/GStreamer stack it needs afterwards.
    extraPkgs =
      pkgs: with pkgs; [
        webkitgtk_4_1
        glib-networking
        gtk3
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
      ];

    # Point GIO at glib-networking's TLS backend inside the FHS sandbox,
    # otherwise the WebKit login view reports "TLS support is not available".
    profile = ''
      export GIO_EXTRA_MODULES=${pkgs.glib-networking}/lib/gio/modules
    '';

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/BambuStudio.desktop $out/share/applications/${pname}.desktop
      install -Dm444 ${appimageContents}/BambuStudio.png $out/share/pixmaps/BambuStudio.png
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in
{
  environment.systemPackages = [ bambu-studio ];
}
