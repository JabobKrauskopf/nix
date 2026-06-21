{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    (pkgs.jellyfin-desktop.overrideAttrs (old: {
      qtWrapperArgs = (old.qtWrapperArgs or [ ]) ++ [
        "--set QT_QPA_PLATFORM xcb"
      ];
    }))
  ];
}
