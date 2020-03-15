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
        name = "ffmpeg-3.3.9";

        src = fetchurl {
            url = "http://www.ffmpeg.org/releases/${name}.tar.bz2";
            sha256 = "01a9rd823i2na11yp9nmwydz2l7ym0i242m28c5lyl4s6yiw8csn";
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

                "--disable-encoders"
                "--disable-hwaccels"
                "--disable-muxers"
                "--enable-parsers"
                "--disable-filters"
                "--disable-devices"
                "--disable-protocols"

                "--enable-pic"
                "--disable-armv5te"
                "--disable-neon"
                "--enable-armv6t2"
                "--enable-armv6"
                "--enable-hardcoded-tables"
                "--disable-debug"

                "--disable-crystalhd"
                "--disable-decoder=h264_vda"
                "--disable-decoder=h264_crystalhd"
                "--disable-decoder=h264_vdpau"
                "--disable-decoder=vc1_crystalhd"
                "--disable-decoder=wmv3_crystalhd"
                "--disable-decoder=wmv3_vdpau"
                "--disable-decoder=mpeg1_vdpau"
                "--disable-decoder=mpeg2_crystalhd"
                "--disable-decoder=mpeg4_crystalhd"
                "--disable-decoder=mpeg4_vdpau"
                "--disable-decoder=mpeg_vdpau"
                "--disable-decoder=mpeg_xvmc"
                "--disable-decoder=msmpeg4_crystalhd"
                "--disable-decoder=vc1_vdpau"
                "--disable-decoder=mpegvideo"
                "--disable-decoder=mpeg1video"
                "--disable-decoder=mpeg2video"
                "--disable-decoder=mvc1"
                "--disable-decoder=mvc2"
                "--disable-decoder=h261"
                "--disable-decoder=h263"
                "--disable-decoder=rv10"
                "--disable-decoder=rv20"
                "--disable-decoder=mjpeg"
                "--disable-decoder=mjpegb"
                "--disable-decoder=sp5x"
                "--disable-decoder=jpegls"
                "--enable-decoder=mpeg4"
                "--disable-decoder=rawvideo"
                "--disable-decoder=msmpeg4v1"
                "--disable-decoder=msmpeg4v2"
                "--disable-decoder=msmpeg4v3"
                "--disable-decoder=wmv1"
                "--disable-decoder=wmv2"
                "--disable-decoder=h263p"
                "--disable-decoder=h263i"
                "--disable-decoder=svq1"
                "--disable-decoder=svq3"
                "--disable-decoder=dvvideo"
                "--disable-decoder=huffyuv"
                "--disable-decoder=cyuv"
                "--enable-decoder=h264"
                "--disable-decoder=indeo3"
                "--disable-decoder=vp3"
                "--disable-decoder=theora"
                "--disable-decoder=asv1"
                "--disable-decoder=asv2"
                "--disable-decoder=ffv1"
                "--disable-decoder=vcr1"
                "--disable-decoder=cljr"
                "--disable-decoder=mdec"
                "--disable-decoder=roq"
                "--disable-decoder=xan_wc3"
                "--disable-decoder=xan_wc4"
                "--disable-decoder=rpza"
                "--disable-decoder=cinepak"
                "--disable-decoder=msrle"
                "--disable-decoder=msvideo1"
                "--disable-decoder=idcin"
                "--disable-decoder=smc"
                "--disable-decoder=flic"
                "--disable-decoder=truemotion1"
                "--disable-decoder=vmdvideo"
                "--disable-decoder=mszh"
                "--disable-decoder=zlib"
                "--disable-decoder=qtrle"
                "--disable-decoder=snow"
                "--disable-decoder=tscc"
                "--disable-decoder=ulti"
                "--disable-decoder=qdraw"
                "--disable-decoder=qpeg"
                "--disable-decoder=png"
                "--disable-decoder=ppm"
                "--disable-decoder=pbm"
                "--disable-decoder=pgm"
                "--disable-decoder=pgmyuv"
                "--disable-decoder=pam"
                "--disable-decoder=ffvhuff"
                "--disable-decoder=rv30"
                "--disable-decoder=rv40"
                "--enable-decoder=vc1"
                "--disable-decoder=wmv3"
                "--disable-decoder=loco"
                "--disable-decoder=wnv1"
                "--disable-decoder=aasc"
                "--disable-decoder=indeo2"
                "--disable-decoder=fraps"
                "--disable-decoder=truemotion2"
                "--disable-decoder=bmp"
                "--disable-decoder=cscd"
                "--disable-decoder=mmvideo"
                "--disable-decoder=zmbv"
                "--disable-decoder=avs"
                "--disable-decoder=nuv"
                "--disable-decoder=kmvc"
                "--disable-decoder=flashsv"
                "--disable-decoder=cavs"
                "--disable-decoder=jpeg2000"
                "--disable-decoder=vmnc"
                "--disable-decoder=vp5"
                "--enable-decoder=vp6"
                "--enable-decoder=vp6f"
                "--disable-decoder=targa"
                "--disable-decoder=dsicinvideo"
                "--disable-decoder=tiertexseqvideo"
                "--disable-decoder=tiff"
                "--disable-decoder=gif"
                "--disable-decoder=dxa"
                "--disable-decoder=thp"
                "--disable-decoder=sgi"
                "--disable-decoder=c93"
                "--disable-decoder=bethsoftvid"
                "--disable-decoder=ptx"
                "--disable-decoder=txd"
                "--disable-decoder=vp6a"
                "--disable-decoder=amv"
                "--disable-decoder=vb"
                "--disable-decoder=pcx"
                "--disable-decoder=sunrast"
                "--disable-decoder=indeo4"
                "--disable-decoder=indeo5"
                "--disable-decoder=mimic"
                "--disable-decoder=rl2"
                "--disable-decoder=escape124"
                "--disable-decoder=dirac"
                "--disable-decoder=bfi"
                "--disable-decoder=motionpixels"
                "--disable-decoder=aura"
                "--disable-decoder=aura2"
                "--disable-decoder=v210x"
                "--disable-decoder=tmv"
                "--disable-decoder=v210"
                "--disable-decoder=dpx"
                "--disable-decoder=frwu"
                "--disable-decoder=flashsv2"
                "--disable-decoder=cdgraphics"
                "--disable-decoder=r210"
                "--disable-decoder=anm"
                "--disable-decoder=iff_ilbm"
                "--disable-decoder=kgv1"
                "--disable-decoder=yop"
                "--enable-decoder=vp8"
                "--disable-decoder=webp"
                "--disable-decoder=pictor"
                "--disable-decoder=ansi"
                "--disable-decoder=r10k"
                "--disable-decoder=mxpeg"
                "--disable-decoder=lagarith"
                "--disable-decoder=prores"
                "--disable-decoder=jv"
                "--disable-decoder=dfa"
                "--disable-decoder=wmv3image"
                "--disable-decoder=vc1image"
                "--disable-decoder=utvideo"
                "--disable-decoder=bmv_video"
                "--disable-decoder=vble"
                "--disable-decoder=dxtory"
                "--disable-decoder=v410"
                "--disable-decoder=xwd"
                "--disable-decoder=cdxl"
                "--disable-decoder=xbm"
                "--disable-decoder=zerocodec"
                "--disable-decoder=mss1"
                "--disable-decoder=msa1"
                "--disable-decoder=tscc2"
                "--disable-decoder=mts2"
                "--disable-decoder=cllc"
                "--disable-decoder=mss2"
                "--disable-decoder=y41p"
                "--disable-decoder=escape130"
                "--disable-decoder=exr"
                "--disable-decoder=avrp"
                "--disable-decoder=avui"
                "--disable-decoder=ayuv"
                "--disable-decoder=v308"
                "--disable-decoder=v408"
                "--disable-decoder=yuv4"
                "--disable-decoder=sanm"
                "--disable-decoder=paf_video"
                "--disable-decoder=avrn"
                "--disable-decoder=cpia"
                "--disable-decoder=bintext"
                "--disable-decoder=xbin"
                "--disable-decoder=idf"
                "--disable-decoder=hevc"
                "--disable-decoder=opus"
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