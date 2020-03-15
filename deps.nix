{pkgsBuildHost, stdenv, fetchurl, fetchFromGitHub, pkgconfig, cmake, pcre, boost, freetype, zlib, dbus, alsaLib, ...}:
{
    inherit pcre boost freetype zlib alsaLib;
    dbus = dbus.dev;
    raspberrypi-tools = stdenv.mkDerivation {
        pname = "raspberrypi-tools";
        version = "2019-07-02";

        src = fetchFromGitHub {
            owner = "raspberrypi";
            repo = "userland";
            rev = "6e6a2c859a17a195fbb6a97c9da584dd2b9b0178";
            sha256 = "0r0zzvxvkb5yvzm6k74slp53q3gahci7a4gjdqgdbmx1gp8awwq4";
        };

        nativeBuildInputs = [ cmake pkgconfig ];

        preConfigure = ''
            cmakeFlagsArray+=("-DVMCS_INSTALL_PREFIX=$out")
        '' + stdenv.lib.optionalString stdenv.isAarch64 ''
            cmakeFlagsArray+=("-DARM64=1")
        '';

        meta = with stdenv.lib; {
            description = "Userland tools for the Raspberry Pi board";
            homepage = https://github.com/raspberrypi/userland;
            license = licenses.bsd3;
            platforms = [ "armv6l-linux" "armv7l-linux" "aarch64-linux" ];
            maintainers = with maintainers; [ dezgeg tavyc ];
        };
    };
    ffmpeg = stdenv.mkDerivation rec {
        name = "ffmpeg-4.2.1";

        src = fetchurl {
            url = "http://www.ffmpeg.org/releases/${name}.tar.bz2";
            sha256 = "090naa6rj46pzkgh03bf51hbqdz356qqckr2pw6pykc6ysiryak8";
        };

        nativeBuildInputs = [ pkgsBuildHost.stdenv.cc ];

        CFLAGS = stdenv.lib.optionalString stdenv.hostPlatform.isAarch32 "-mfpu=vfp -mfloat-abi=hard";

        configurePlatforms = [];
        configureFlags =
            stdenv.lib.optionals stdenv.hostPlatform.isAarch32 [
            "--cpu=arm1176jzf-s"
            ] ++ [
                "--arch=${stdenv.hostPlatform.parsed.cpu.name}"
                "--target_os=${stdenv.hostPlatform.parsed.kernel.name}"

                "--enable-gpl"
                "--enable-version3"
                "--enable-nonfree"

                "--enable-static"
                "--enable-shared"
                "--disable-runtime-cpudetect"

                "--disable-programs"
                "--disable-doc"

                "--disable-postproc"
                "--enable-pthreads"
                "--disable-network"

                "--disable-decoders"
                "--disable-encoders"
                "--disable-hwaccels"
                "--disable-muxers"
                "--disable-parsers"
                "--disable-filters"
                "--disable-devices"
                "--disable-protocols"

                "--enable-pic"
                "--enable-hardcoded-tables"
                "--disable-debug"

                "--disable-crystalhd"
                "--enable-decoder=mpeg4"
                "--enable-decoder=h264"
                "--enable-decoder=vc1"
                "--enable-decoder=vp6"
                "--enable-decoder=vp6f"
                "--enable-decoder=vp8"

                "--enable-parser=mpeg4video"
            ] ++ stdenv.lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
                "--cross-prefix=${stdenv.cc.targetPrefix}"
                "--host-cc=${pkgsBuildHost.stdenv.cc.targetPrefix}cc"
                "--enable-cross-compile"
            ];

        enableParallelBuilding = true;

        meta = {
            homepage = http://www.ffmpeg.org/;
            description = "A customized play-only version of FFMPEG for Raspberry Pis";
            platforms = stdenv.lib.platforms.arm;
        };
    };
}