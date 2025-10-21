{
  lib,
  fetchurl,
  autoconf,
  automake,
  makeWrapper,
  tcl,
  tclcl,
  otcl,
  xorg,
  perl,
  tk,
  stdenv,
  withPatch ? false,
}:
stdenv.mkDerivation rec {
    pname = "ns";
    version = "2.35";

    src = builtins.fetchTarball {
      url = "http://sourceforge.net/projects/nsnam/files/allinone/ns-allinone-${version}/ns-allinone-${version}.tar.gz/download";
      sha256 = "sha256:0dap4rbqnpwazg8b3mdk63hi5403j7rm9p498wjh4wr9f0vspmjd";
    };

    sourceRoot = "source/ns-${version}";

    patches = [
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-gcc-compile-errors.patch?h=ns";
        sha256 = "sha256-06bmvMIsqaqPiQF3TrWKTfPy9NaFaiYFYVaKWm2fYA4=";
      })
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-getopts.patch?h=ns";
        sha256 = "sha256-TQL/DPHHnWfEQMeI1xY8fIc6bk4pcLqzMZy+KfmyDBQ=";
      })
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-linkstate-erase.fix?h=ns";
        sha256 = "sha256-rtumRtG8TXFgMfnqmW5tmcm7In52RxOMzPOb3WwGnDo=";
      })
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-random-return-type.patch?h=ns";
        sha256 = "sha256-sXwhBOjm/2fyt4NZM/EfLux/SsUqxnlz7BuzAssFNag=";
      })
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-tcl86.patch?h=ns";
        sha256 = "sha256-eqSiJJLyvjfIH83IE5cqa94QXhg6AT17gUpW97zvhyw=";
      })
      (fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/ns-2.35-use-std-cpp14.patch?h=ns";
        sha256 = "2fac6b24607dedfd8b96c70a9222f0b92318b2cf0cc1501caf8c1a796771547d";
      })
    ] ++ lib.optionals withPatch [./print-timeout.patch] ;

    nativeBuildInputs = [
      autoconf
      automake
      makeWrapper
      xorg.libXt
      tcl
      tk
      perl
    ];

    enableParallelBuilding = true;

    configureFlags = [
      "--with-otcl=${otcl}"
      "--with-tclcl=${tclcl}"
      "--with-tcl=${tcl}"
      "--with-tk=${tk}"
      "--prefix=${placeholder "out"}"
    ];

    
    preInstall = ''
      mkdir -p "$out/bin" "$out/man/man1"
    '';

    mainProgram = "ns";

    meta = with lib; {
      description = "Discrete event simulator targeted at networking research (ns‑2)";
      homepage = "http://www.isi.edu/nsnam/ns/";
      mantainer = "pablito2020";
      license = licenses.gpl2;
    };
  }
