{ lib, stdenv, fetchurl, nixosTests }:

stdenv.mkDerivation rec {
  pname = "wordpress";
  version = "5.8.2";

  src = fetchurl {
    url = "https://wordpress.org/${pname}-${version}.tar.gz";
    sha256 = "sha256-o9KeTmZXTHtqa/Z2KOo1n6gVCFuna42dFrvf9OBC8v8=";
  };

  installPhase = ''
    mkdir -p $out/share/wordpress
    cp -r . $out/share/wordpress
  '';

  passthru.tests = {
    inherit (nixosTests) wordpress;
  };

  meta = with lib; {
    homepage = "https://wordpress.org";
    description = "WordPress is open source software you can use to create a beautiful website, blog, or app";
    license = [ licenses.gpl2 ];
    maintainers = [ maintainers.basvandijk ];
    platforms = platforms.all;
  };
}
