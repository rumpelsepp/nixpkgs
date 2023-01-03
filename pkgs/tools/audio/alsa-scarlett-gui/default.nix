{ lib
, stdenv
, fetchFromGitHub
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "alsa-scarlett-gui";
  version = "0.2";

  src = fetchFromGitHub {
    owner = "geoffreybennett";
    repo = "alsa-scarlett-gui";
    rev = version;
  };

  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    homepage = "https://github.com/geoffreybennett/alsa-scarlett-gui";
    description = "alsa-scarlett-gui is a Gtk4 GUI for the ALSA controls presented by the Linux kernel Focusrite Scarlett Gen 2/3 Mixer Driver";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ rumpelsepp ];
    platforms = platforms.linux;
  };
}
