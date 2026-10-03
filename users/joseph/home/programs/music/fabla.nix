{ stdenv, fetchFromGitHub, cmake, pkg-config, lv2, libsndfile, ntk, cairo, libX11
, libXft, libGL, lib
}:

stdenv.mkDerivation {
  pname = "openAV-Fabla";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "openAVproductions";
    repo = "openAV-Fabla";
    rev = "254ff8827832683d4229f4b865293b60644faff8";
    hash = "sha256-9nRK5CbXo4w56bC0Plm+YDD2r+smrjIG+SmpRxa9yww=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    lv2
    libsndfile
    ntk
    cairo
    libX11
    libXft
    libGL
  ];

  dontStrip = true;

  postPatch = ''
    # Upstream wants a hand-written ntk-static.pc with hardcoded /usr/local
    # paths. Use nixpkgs' ntk.pc instead, and name the deps it hides in
    # Requires.private explicitly: pkg-config --static can't resolve them
    # without dragging in the whole X11/fontconfig closure.
    substituteInPlace CMakeLists.txt \
      --replace-fail 'pkg_check_modules(NTK ntk-static REQUIRED)' \
        'pkg_check_modules(NTK ntk REQUIRED)
        pkg_check_modules(X11 x11 REQUIRED)
        pkg_check_modules(XFT xft REQUIRED)' \
      --replace-fail 'target_link_libraries( fabla ''${NTK_LIBRARIES}     )' \
        'target_link_libraries( fabla ''${NTK_LIBRARIES} ''${X11_LIBRARIES} ''${XFT_LIBRARIES} )'

    # manifest.ttl declares the plugin without the doap:name the LV2 spec
    # requires, so hosts that don't fall back to the URI end up showing
    # nothing. fabla.ttl has the name, but the manifest has to carry it too.
    substituteInPlace dsp/manifest.ttl \
      --replace-fail '@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .' \
        '@prefix doap: <http://usefulinc.com/ns/doap#> . @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .' \
      --replace-fail '  a lv2:Plugin ;' \
        '  a lv2:Plugin ; doap:name "Fabla"; lv2:project [ doap:name "OpenAV Productions" ];'
  '';

  meta = {
    description = "Performance sampler LV2 plugin";
    homepage = "http://openavproductions.com/fabla";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.unix;
  };
}