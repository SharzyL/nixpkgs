{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "gnumake";
  version = "3.82";

  src = fetchurl {
    url = "mirror://gnu/make/make-${version}.tar.bz2";
    sha256 = "0ri98385hsd7li6rh4l5afcq92v8l2lgiaz85wgcfh4w2wzsghg2";
  };

  patches = [
    ./impure-dirs.patch
    ./log.patch
    ./alloca.patch
  ];

  outputs = [ "out" "man" "info" ];

  meta = with lib; {
    description = "A tool to control the generation of non-source files from sources";
    longDescription = ''
      Make is a tool which controls the generation of executables and
      other non-source files of a program from the program's source files.

      Make gets its knowledge of how to build your program from a file
      called the makefile, which lists each of the non-source files and
      how to compute it from other files. When you write a program, you
      should write a makefile for it, so that it is possible to use Make
      to build and install the program.
    '';
    homepage = "https://www.gnu.org/software/make/";

    license = licenses.gpl3Plus;
    maintainers = [ maintainers.vrthra ];
    mainProgram = "make";
    platforms = platforms.all;
  };
}
