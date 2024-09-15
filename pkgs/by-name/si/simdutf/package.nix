{ lib
, stdenv
, fetchFromGitHub
, cmake
, libiconv
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "simdutf";
  version = "5.5.0";

  src = fetchFromGitHub {
    owner = "simdutf";
    repo = "simdutf";
    rev = "v${finalAttrs.version}";
    hash = "sha256-LEXx/b0DJZ9xxQX9+4YHjQCLFp2aXCE78Z6iPlXJjAw=";
  };

  # Fix build on darwin
  postPatch = ''
    substituteInPlace tools/CMakeLists.txt --replace "-Wl,--gc-sections" ""
  '';

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    libiconv
  ];

  meta = with lib; {
    description = "Unicode routines validation and transcoding at billions of characters per second";
    homepage = "https://github.com/simdutf/simdutf";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ rewine ];
    mainProgram = "simdutf";
    platforms = platforms.all;
  };
})
