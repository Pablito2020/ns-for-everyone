{
  lib,
  stdenv,
  fetchurl,
  tk,
  libXt,
  gcc,
  tcl,
}:
stdenv.mkDerivation rec {
    pname = "otcl";
    version = "1.14";

    src = builtins.fetchTarball {
      url = "https://sourceforge.net/projects/otcl-tclcl/files/OTcl/${version}/otcl-src-${version}.tar.gz/download";
      sha256 = "sha256:09alhrbq7pyibfk8j6lhv2m3rhjhm6cb3l6ny355prxw07jxmggk";
    };

    patches = [
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/otcl-1.14-tcl86-compat.patch?h=otcl";
        sha256 = "ac355cabd47a408242a909a2f5c7ad8c522c22fabad1180c44197bb6ac1db3a6";
      })
    ];

    nativeBuildInputs = [
      gcc
      tk
      libXt
    ];
    buildInputs = [libXt];

    configureFlags = [
       "--with-tcl=${tcl}"
       "--with-tk=${tk}"
       "--prefix=${placeholder "out"}"
     ];

    meta = with lib; {
      description = "An extension to Tcl/Tk for object-oriented programming";
      homepage = "http://otcl-tclcl.sourceforge.net/otcl/";
      license = licenses.mit;
      maintainer = "pablito2020";
    };
  }
