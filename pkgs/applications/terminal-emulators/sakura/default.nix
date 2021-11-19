{ lib
, stdenv
, fetchFromGitHub
, cmake
, glib
, gtk3
, makeWrapper
, pcre2
, perl
, pkg-config
, vte
}:

stdenv.mkDerivation rec {
  pname = "sakura";
  version = "3.8.4";

  src = fetchFromGitHub {
    owner = "dabisu";
    repo = pname;
    rev = "SAKURA_${lib.replaceStrings [ "." ] [ "_" ] version}";
    hash = "sha256-Sqo1gyCvCMlEv1rYqw6P3Dmu10osi/KqB7/WlgTTNAc=";
  };

  nativeBuildInputs = [
    cmake
    makeWrapper
    perl
    pkg-config
  ];

  buildInputs = [
    glib
    gtk3
    pcre2
    vte
  ];

  # Set path to gsettings-schemata so sakura knows where to find colorchooser,
  # fontchooser etc.
  postFixup = ''
    wrapProgram $out/bin/sakura \
      --suffix XDG_DATA_DIRS : ${gtk3}/share/gsettings-schemas/${gtk3.name}/
  '';

  meta = with lib; {
    homepage = "https://www.pleyades.net/david/projects/sakura";
    description = "A terminal emulator based on GTK and VTE";
    longDescription = ''
      sakura is a terminal emulator based on GTK and VTE. It's a terminal
      emulator with few dependencies, so you don't need a full GNOME desktop
      installed to have a decent terminal emulator. Current terminal emulators
      based on VTE are gnome-terminal, XFCE Terminal, TermIt and a small
      sample program included in the vte sources. The differences between
      sakura and the last one are that it uses a notebook to provide several
      terminals in one window and adds a contextual menu with some basic
      options. No more no less.
    '';
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ astsmtl codyopel AndersonTorres ];
    platforms = platforms.linux;
 };
}
