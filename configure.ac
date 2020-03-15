AC_PREREQ([2.69])

AC_INIT([omxplayer], [1.0.0-custom]) 
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])

VERSION_DATE=$(date -R 2> /dev/null)

AC_PATH_PROG(GIT, git)

AS_IF( [test "$GIT" = ""], [
        VERSION_HASH="UNKNOWN"
        VERSION_BRANCH="UNKNOWN"
        VERSION_REPO="UNKNOWN"
     ], [
        GitRef=$($GIT symbolic-ref -q HEAD 2> /dev/null)
        AS_IF([test "x$?" = "x0"], [
                VERSION_HASH=$($GIT rev-parse --short $GitRef 2> /dev/null)
                VERSION_BRANCH=${GitRef#refs/heads/}

                GitUpstream=$($GIT for-each-ref --format='%(upstream:short)' $GitRef 2> /dev/null)
                AS_IF([test "x$GitUpstream" != "x"], [VERSION_REPO=$($GIT config remote.${GitUpstream%/$VERSION_BRANCH}.url)])
            ], [
                VERSION_HASH="UNKNOWN"
                VERSION_BRANCH="UNKNOWN"
                VERSION_REPO="UNKNOWN"
             ]
        )
     ]
)

AC_SUBST([VERSION_DATE])
AC_SUBST([VERSION_HASH])
AC_SUBST([VERSION_BRANCH])
AC_SUBST([VERSION_REPO])

AC_CANONICAL_BUILD
AC_CANONICAL_HOST

AC_CONFIG_SRCDIR([OMXPlayerVideo.cpp])
AC_CONFIG_HEADER(config.h)
AC_CONFIG_FILES([Makefile version.h])

AC_PROG_CXX()
AC_PATH_PROG(STRIP, [strip])

AC_CHECK_HEADER([bcm_host.h], [], [AC_MSG_ERROR([Missing bcm_host.h header file. Please make you you've installed the Raspberry Pi userland tools.])])

AC_ARG_ENABLE([alsa],
    AS_HELP_STRING([--disable-alsa], [Disable alsa sound support]))
AS_IF([test "x$enable_alsa" != "xno"], [
    AC_CHECK_HEADER([alsa/asoundlib.h], [], [AC_MSG_ERROR([Cannot find alsa/asoundlib.h.])])
    AC_SEARCH_LIBS([snd_pcm_open], [asound], [], [AC_MSG_ERROR([Cannot find the asound library.])])
])

AC_ARG_ENABLE([dbus],
    AS_HELP_STRING([--disable-dbus], [Disable DBus support]))
AS_IF([test "x$enable_dbus" != "xno"], [
    AC_CHECK_HEADER([dbus/dbus.h], [], [AC_MSG_ERROR([Cannot find dbus/dbus.h.])])
    AC_SEARCH_LIBS([dbus_bus_request_name], [dbus-1], [], [AC_MSG_ERROR([Cannot find the dbus library.])])
])

AC_CHECK_HEADERS( [IL/OMX_Core.h]
                , []
                , [AC_MSG_ERROR([Cannot find one of the openmaxil header files.])]
                )
AC_SEARCH_LIBS([OMX_Init], [openmaxil], [], [AC_MSG_ERROR([Cannot find the openmaxil library.])])

AC_CHECK_HEADERS( [libswresample/swresample.h]
                , []
                , [AC_MSG_ERROR([Cannot find one of the libswresample header files.])]
                )
AC_SEARCH_LIBS([swr_alloc_set_opts], [swresample], [], [AC_MSG_ERROR([Cannot find the swresample library.])])

AC_CHECK_HEADERS( [libavcodec/avcodec.h]
                , []
                , [AC_MSG_ERROR([Cannot find one of the libav header files.])]
                )
AC_SEARCH_LIBS([avpicture_alloc], [avcodec], [], [AC_MSG_ERROR([Cannot find the avcodec library.])])

AC_CHECK_HEADERS( [libavformat/avformat.h]
                , []
                , [AC_MSG_ERROR([Cannot find one of the libavformat header files.])]
                )
AC_SEARCH_LIBS([avformat_alloc_context], [avformat], [], [AC_MSG_ERROR([Cannot find the avformat library.])])

AC_CHECK_HEADERS([libavutil/avutil.h libavutil/opt.h libavutil/mem.h]
                , []
                , [AC_MSG_ERROR([Cannot find one of the libavutil header files.])]
                )
AC_SEARCH_LIBS([av_d2q], [avutil], [], [AC_MSG_ERROR([Cannot find the libavutil library.])])

AC_SEARCH_LIBS([pcre_compile], [pcre], [], [AC_MSG_ERROR([Cannot find the pcre library.])])

AC_SEARCH_LIBS([vc_tv_unregister_callback], [bcm_host], [], [AC_MSG_ERROR([Cannot find the bcm_host library.])])

AC_SEARCH_LIBS([FT_Stroker_New], [freetype], [], [AC_MSG_ERROR([Cannot find the freetype library.])])

LIBS="$LIBS -lEGL"

CXXFLAGS="$CXXFLAGS -Ilinux"
CXXFLAGS="$CXXFLAGS -fomit-frame-pointer -mabi=aapcs-linux -g -pthread"
CXXFLAGS="$CXXFLAGS -DTARGET_POSIX -DTARGET_LINUX -DTARGET_RASPBERRY_PI"

CXXFLAGS="$CXXFLAGS -DUSE_EXTERNAL_FFMPEG"
CXXFLAGS="$CXXFLAGS -DUSE_EXTERNAL_LIBBCM_HOST"
CXXFLAGS="$CXXFLAGS -DUSE_EXTERNAL_OMX"
CXXFLAGS="$CXXFLAGS -DHAVE_OMXLIB"
CXXFLAGS="$CXXFLAGS -DOMX -DOMX_SKIP64BIT"
CXXFLAGS="$CXXFLAGS -D__VIDEOCORE4__"

CXXFLAGS="$CXXFLAGS -fPIC -DPIC"
CXXFLAGS="$CXXFLAGS -Wall -Wno-deprecated-declarations"
CXXFLAGS="$CXXFLAGS -std=c++0x -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -D_REENTRANT -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -U_FORTIFY_SOURCE -ftree-vectorize"

AC_OUTPUT
