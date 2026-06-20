{ lib, ... }:

{
  home.file.".gitconfig".text = ''
    [user]
      name = Jakob Kraus
      email = mail@jakobkraus.de
  '';
}
