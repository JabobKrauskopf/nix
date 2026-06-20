{ defaultUser, ... }:

{
  programs.firefox.enable = true;
  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1; # This makes Firefox use Dolphin for file picking
    "middlemouse.paste" = false; # Firefox > about:config > middlemouse.paste: false
    "general.autoScroll" = true; # Enables scrolling with middle mouse button
  };
}
