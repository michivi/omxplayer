bin_PROGRAMS = omxplayer

EXTRA_DIST = README.md fonts/FreeSans.ttf fonts/FreeSansOblique.ttf

omxplayer_SOURCES = \
	BitstreamConverter.cpp \
	DllAvCodec.h \
	DllAvFormat.h \
	DllAvUtil.h \
	DllBCM.h \
	DllOMX.h \
	DllSwResample.h \
	DynamicDll.cpp \
	DynamicDll.h \
	File.cpp \
	File.h \
	guilib/Geometry.h \
	help.h \
	Keyboard.cpp \
	Keyboard.h \
	KeyConfig.cpp \
	KeyConfig.h \
	keys.h \
	linux/ConvUtils.h \
	linux/PlatformDefs.h \
	linux/PlatformInclude.h \
	linux/RBP.cpp \
	linux/RBP.h \
	linux/stat_utf8.h \
	linux/stdio_utf8.h \
	linux/XMemUtils.cpp \
	linux/XMemUtils.h \
	linux/XSyncUtils.h \
	OMXAudio.cpp \
	OMXAudio.h \
	OMXAudioCodecOMX.cpp \
	OMXAudioCodecOMX.h \
	OMXClock.cpp \
	OMXClock.h \
	OMXControl.cpp \
	OMXControl.h \
	OMXCore.cpp \
	OMXCore.h \
	OMXOverlay.h \
	OMXOverlayCodec.h \
	omxplayer.cpp \
	OMXPlayerAudio.cpp \
	OMXPlayerAudio.h \
	OMXPlayerVideo.cpp \
	OMXPlayerVideo.h \
	OMXReader.cpp \
	OMXReader.h \
	OMXStreamInfo.cpp \
	OMXStreamInfo.h \
	OMXThread.cpp \
	OMXThread.h \
	OMXVideo.cpp \
	OMXVideo.h \
	RBP.h \
	revision.cpp \
	revision.h \
	Subtitle.h \
	system.h \
	Unicode.cpp \
	Unicode.h \
	utils/Clamp.h \
	utils/Enforce.h \
	utils/FunctorVisitor.h \
	utils/LockBlock.h \
	utils/log.cpp \
	utils/log.h \
	utils/Mailbox.h \
	utils/MathUtils.h \
	utils/PCMRemap.cpp \
	utils/PCMRemap.h \
	utils/ScopeExit.h \
	utils/SingleLock.h \
	utils/StdString.h \
	utils/Strprintf.h

if HAVE_SOUND
omxplayer_SOURCES += \
	linux/OMXAlsa.cpp \
	linux/OMXAlsa.h
endif

omxplayer_fonts_dir = $(pkgdatadir)/fonts
omxplayer_fonts__DATA =

if HAVE_SUBTITLES
omxplayer_fonts__DATA += fonts/FreeSans.ttf fonts/FreeSansOblique.ttf

omxplayer_SOURCES += \
	OMXOverlayCodecText.cpp \
	OMXOverlayCodecText.h \
	OMXOverlayText.h \
	OMXPlayerSubtitles.cpp \
	OMXPlayerSubtitles.h \
	OMXSubtitleTagSami.cpp \
	OMXSubtitleTagSami.h \
	Srt.cpp \
	Srt.h \
	SubtitleRenderer.cpp \
	SubtitleRenderer.h \
	utils/RegExp.cpp \
	utils/RegExp.h
endif

nodist_omxplayer_SOURCES =	help.h keys.h

BUILT_SOURCES =	help.h keys.h

CLEANFILES =	help.h keys.h

help.h: README.md Makefile
	awk '/SYNOPSIS/{p=1;print;next} p&&/KEY BINDINGS/{p=0};p' $< \
	| sed -e '1,3 d' -e 's/^/"/' -e 's/$$/\\n"/' \
	> $@

keys.h: README.md Makefile
	awk '/KEY BINDINGS/{p=1;print;next} p&&/KEY CONFIG/{p=0};p' $< \
	| sed -e '1,3 d' -e 's/^/"/' -e 's/$$/\\n"/' \
	> $@
