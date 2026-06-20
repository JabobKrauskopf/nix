{ lib, ... }:

{
  home.file.".gitconfig".text = ''
    [user]
      name = Jakob Kraus
      email = mail@jakobkraus.de
  '';

  xdg.dataFile = {
    "kio/servicemenus/open-in-vscode.desktop" = {
      text = ''
        [Desktop Entry]
        Type=Service
        MimeType=inode/directory;
        Actions=openInVSCode;
        X-KDE-Priority=TopLevel

        [Desktop Action openInVSCode]
        Name=Open in VS Code
        Icon=vscode
        Exec=code %F
      '';
      executable = true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
}
