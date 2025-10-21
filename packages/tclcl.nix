{
  stdenv,
  fetchurl,
  otcl,
  gcc,
  libXt,
  lib,
  tk,
  tcl,
}:
stdenv.mkDerivation rec {
    pname = "tclcl";
    version = "1.20";

    src = builtins.fetchTarball {
      url = "https://sourceforge.net/projects/otcl-tclcl/files/TclCL/${version}/tclcl-src-${version}.tar.gz/download";
      sha256 = "sha256:1gr300y0kh9r9fvlh5hz8pkh40j5272zhafq0cqp5vb1f4rj3xqr";
    };

    patches = [
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/tclcl-1.20-tcl86-compat.patch?h=tclcl";
        sha256 = "8c1d4672013463ff9ccef0f064e739643a4ae50d2e3909e8943791ba8d1c275f";
      })
    ];

    nativeBuildInputs = [
      gcc
      otcl
      tk
      tcl
    ];
    buildInputs = [libXt];

    configureFlags = [
       "--with-otcl=${otcl}"
       "--with-tcl=${tcl}"
       "--with-tk=${tk}"
       "--prefix=${placeholder "out"}"
     ];


    preInstall = ''
      mkdir -p "$out/bin" "$out/include" "$out/lib"
    '';

    meta = with lib; {
      description = "Tcl with classes (TclCl) is a Tcl/C++ interface";
      homepage = "http://otcl-tclcl.sourceforge.net/tclcl/";
      license = licenses.mit;
      maintainer = "pablito2020";
    };
  }
