{ pkgs, config }:

with pkgs;
let wallpaper = fetchurl {
  url = "https://wallpapercave.com/wp/2gtTP2Y.jpg";
  sha256 = "0ylpfl2wylzyi7imhl3igq1rgsxihiaykp87784hyfqy69pkydsq";
};
in
writeText "onAttachMonitor" ''
  ${xorg.xmodmap}/bin/xmodmap ${config.home.homeDirectory}/.Xmodmap
  ${compton}/bin/compton -z -D 0 -m 0.7 --inactive-dim 0.2 --inactive-dim-fixed -b -C --focus-exclude "x = 0 && y = 0 && override_redirect = true"  --focus-exclude '_NET_WM_NAME@:s = "rofi"' --backend glx
  ${feh}/bin/feh --bg-scale ${wallpaper}
  ${pasystray}/bin/pasystray &
''
