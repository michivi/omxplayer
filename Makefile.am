bin_PROGRAMS = omxplayer

EXTRA_DIST = README.md

omxplayer_SOURCES = \
	BitstreamConverter.cpp \
	DynamicDll.cpp \
	File.cpp \
	Keyboard.cpp \
	KeyConfig.cpp \
	linux/OMXAlsa.cpp \
	linux/RBP.cpp \
	linux/XMemUtils.cpp \
	OMXAudio.cpp \
	OMXAudioCodecOMX.cpp \
	OMXClock.cpp \
	OMXControl.cpp \
	OMXCore.cpp \
	OMXOverlayCodecText.cpp \
	omxplayer.cpp \
	OMXPlayerAudio.cpp \
	OMXPlayerSubtitles.cpp \
	OMXPlayerVideo.cpp \
	OMXReader.cpp \
	OMXStreamInfo.cpp \
	OMXSubtitleTagSami.cpp \
	OMXThread.cpp \
	OMXVideo.cpp \
	revision.cpp \
	Srt.cpp \
	SubtitleRenderer.cpp \
	Unicode.cpp \
	utils/log.cpp \
	utils/PCMRemap.cpp \
	utils/RegExp.cpp \
	help.h \
	keys.h

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
