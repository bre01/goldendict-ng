TEMPLATE = app
TARGET = goldendict
VERSION = 23.04.03-alpha

# Generate version file. We do this here and in a build rule described later.
# The build rule is required since qmake isn't run each time the project is
# rebuilt; and doing it here is required too since any other way the RCC
# compiler would complain if version.txt wouldn't exist (fresh checkouts).

system(git describe --tags --always --dirty): hasGit=1

!isEmpty(hasGit){
    GIT_HASH=$$system(git rev-parse --short=8 HEAD )
}

!exists( version.txt ) {
      message( "generate version.txt...." )
      system(echo $${VERSION}.$${GIT_HASH} on $${_DATE_} > version.txt)
}


!CONFIG( verbose_build_output ) {
  !win32|*-msvc* {
    # Reduce build log verbosity except for MinGW builds (mingw-make cannot
    # execute "@echo ..." commands inserted by qmake).
    CONFIG += silent
  }
}

CONFIG( release, debug|release ) {
  DEFINES += NDEBUG
}

# DEPENDPATH += . generators
INCLUDEPATH += .
INCLUDEPATH += ./src/

QT += core \
      gui \
      xml \
      network \
      svg \
      widgets \
      webenginewidgets\
      webchannel\
      printsupport \
      concurrent \
      texttospeech

greaterThan(QT_MAJOR_VERSION, 5): QT += webenginecore core5compat

DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050F00

!CONFIG( no_qtmultimedia_player ) {
  QT += multimedia
  DEFINES += MAKE_QTMULTIMEDIA_PLAYER
}

!CONFIG( no_ffmpeg_player ) {
  # ffmpeg depended on multimedia now.
  QT += multimedia
  DEFINES += MAKE_FFMPEG_PLAYER
}

contains(DEFINES, MAKE_QTMULTIMEDIA_PLAYER|MAKE_FFMPEG_PLAYER) {
  HEADERS += \
  src/audiooutput.hh
  SOURCES += \
  src/audiooutput.cc
}

# on windows platform ,only works in release build

CONFIG( use_xapian ) {
  DEFINES += USE_XAPIAN

  LIBS+= -lxapian
}

CONFIG( use_iconv ) {
  DEFINES += USE_ICONV
  unix:!mac{
    #ignore
  }
  else {
      LIBS+= -liconv
  }
}

CONFIG += exceptions \
    rtti \
    stl  \
    c++17 \
    lrelease \
    utf8_source \
    force_debug_info

mac {
    CONFIG += app_bundle
}
    
OBJECTS_DIR = build
UI_DIR = build
MOC_DIR = build
RCC_DIR = build
LIBS += -lz \
        -lbz2 \
        -llzo2

win32 {
    QM_FILES_INSTALL_PATH = /locale/
    TARGET = GoldenDict

    win32-msvc* {
        # VS does not recognize 22.number.alpha,cause errors during compilation under MSVC++
        VERSION = 23.04.03 
        DEFINES += __WIN32 _CRT_SECURE_NO_WARNINGS
        contains(QMAKE_TARGET.arch, x86_64) {
            DEFINES += NOMINMAX __WIN64
        }
        LIBS += -L$${PWD}/winlibs/lib/msvc
        # silence the warning C4290: C++ exception specification ignored
        QMAKE_CXXFLAGS += /wd4290 /Zc:__cplusplus /std:c++17 /permissive- 
        # QMAKE_LFLAGS_RELEASE += /OPT:REF /OPT:ICF

        # QMAKE_CXXFLAGS_RELEASE += /GL # slows down the linking significantly
        LIBS += -lshell32 -luser32 -lsapi -lole32
        Debug: LIBS+= -lhunspelld
        Release: LIBS+= -lhunspell
        HUNSPELL_LIB = hunspell
    }

    LIBS += -lwsock32 \
        -lpsapi \
        -lole32 \
        -loleaut32 \
        -ladvapi32 \
        -lcomdlg32
    LIBS += -lvorbisfile \
        -lvorbis \
        -logg
    !CONFIG( no_ffmpeg_player ) {
        LIBS += -lswresample \
            -lavutil \
            -lavformat \
            -lavcodec
    }

    RC_ICONS += icons/programicon.ico icons/programicon_old.ico
    INCLUDEPATH += winlibs/include

    # Enable console in Debug mode on Windows, with useful logging messages
    Debug:CONFIG += console

    Release:DEFINES += NO_CONSOLE

    gcc48:QMAKE_CXXFLAGS += -Wno-unused-local-typedefs

    !CONFIG( no_chinese_conversion_support ) {
        CONFIG += chinese_conversion_support
    }
}
!CONFIG( no_macos_universal ) {
    DEFINES += INCLUDE_LIBRARY_PATH
}
unix:!mac {
    DEFINES += HAVE_X11

    lessThan(QT_MAJOR_VERSION, 6):     QT += x11extras

    CONFIG += link_pkgconfig

    PKGCONFIG += vorbisfile \
        vorbis \
        ogg \
        hunspell
    !CONFIG( no_ffmpeg_player ) {
        PKGCONFIG += libavutil \
            libavformat \
            libavcodec \
            libswresample \
    }
    !arm {
        LIBS += -lX11 -lXtst
    }

    # Install prefix: first try to use qmake's PREFIX variable,
    # then $PREFIX from system environment, and if both fails,
    # use the hardcoded /usr/local.
    PREFIX = $${PREFIX}
    isEmpty( PREFIX ):PREFIX = $$(PREFIX)
    isEmpty( PREFIX ):PREFIX = /usr/local
    message(Install Prefix is: $$PREFIX)

    DEFINES += PROGRAM_DATA_DIR=\\\"$$PREFIX/share/goldendict/\\\"
    target.path = $$PREFIX/bin/
    locale.path = $$PREFIX/share/goldendict/locale/
    locale.files = locale/*.qm
    INSTALLS += target \
        locale
    icons.path = $$PREFIX/share/pixmaps
    icons.files = redist/icons/*.*
    INSTALLS += icons
    desktops.path = $$PREFIX/share/applications
    desktops.files = redist/*.desktop
    INSTALLS += desktops
    metainfo.path = $$PREFIX/share/metainfo
    metainfo.files = redist/*.metainfo.xml
    INSTALLS += metainfo
}
freebsd {
    LIBS +=   -lexecinfo
}
mac {
    QM_FILES_INSTALL_PATH = /locale/
    TARGET = GoldenDict
    # Uncomment this line to make a universal binary.
    # You will need to use Xcode 3 and Qt Carbon SDK
    # if you want the support for PowerPC and/or Mac OS X 10.4
    # CONFIG += x86 x86_64 ppc
    LIBS += -lz \
        -lbz2 \
        -lvorbisfile \
        -lvorbis \
        -logg \
        -llzo2

    !CONFIG( no_ffmpeg_player ) {
        LIBS += -lswresample \
            -lavutil \
            -lavformat \
            -lavcodec
    }
    QT_CONFIG -= no-pkg-config
    CONFIG += link_pkgconfig


    !CONFIG( no_macos_universal ) {
        LIBS+=        -lhunspell
        INCLUDEPATH += $${PWD}/maclibs/include
        LIBS += -L$${PWD}/maclibs/lib -framework AppKit -framework Carbon
    }
    else{
        PKGCONFIG +=   hunspell
        INCLUDEPATH += /opt/homebrew/include /usr/local/include
        LIBS += -L/opt/homebrew/lib -L/usr/local/lib -framework AppKit -framework Carbon
    }

    OBJECTIVE_SOURCES += machotkeywrapper.mm \
                         macmouseover.mm
    ICON = icons/macicon.icns
    QMAKE_INFO_PLIST = myInfo.plist

    !CONFIG( no_macos_universal ) {
        QMAKE_POST_LINK = mkdir -p GoldenDict.app/Contents/Frameworks && \
                          cp -nR $${PWD}/maclibs/lib/ GoldenDict.app/Contents/Frameworks/ && \
                          mkdir -p GoldenDict.app/Contents/MacOS/locale && \
                          cp -R locale/*.qm GoldenDict.app/Contents/MacOS/locale/
    }
    else{
        QMAKE_POST_LINK = mkdir -p GoldenDict.app/Contents/Frameworks && \
                          cp -nR $${PWD}/maclibs/lib/libeb.dylib GoldenDict.app/Contents/Frameworks/ && \
                          mkdir -p GoldenDict.app/Contents/MacOS/locale && \
                          cp -R locale/*.qm GoldenDict.app/Contents/MacOS/locale/
    }

    !CONFIG( no_chinese_conversion_support ) {
        CONFIG += chinese_conversion_support
        QMAKE_POST_LINK += && mkdir -p GoldenDict.app/Contents/MacOS/opencc && \
                             cp -R $${PWD}/opencc/*.* GoldenDict.app/Contents/MacOS/opencc/
    }

}
DEFINES += PROGRAM_VERSION=\\\"$$VERSION\\\"

# Input
HEADERS += \
    src/about.hh \
    src/ankiconnector.hh \
    src/article_inspect.hh \
    src/article_maker.hh \
    src/article_netmgr.hh \
    src/articlewebpage.hh \
    src/articlewebview.hh \
    src/atomic_rename.hh \
    src/audiolink.hh \
    src/audioplayerfactory.hh \
    src/audioplayerinterface.hh \
    src/base/globalregex.hh \
    src/base_type.hh \
    src/btreeidx.hh \
    src/chunkedstorage.hh \
    src/config.hh \
    src/country.hh \
    src/decompress.hh \
    src/delegate.hh \
    src/dict/aard.hh \
    src/dict/belarusiantranslit.hh \
    src/dict/bgl.hh \
    src/dict/bgl_babylon.hh \
    src/dict/dictionary.hh \
    src/dict/dsl.hh \
    src/dict/dsl_details.hh \
    src/dict/forvo.hh \
    src/dict/german.hh \
    src/dict/gls.hh \
    src/dict/greektranslit.hh \
    src/dict/hunspell.hh \
    src/dict/lingualibre.hh \
    src/dict/lsa.hh \
    src/dict/mdx.hh \
    src/dict/mediawiki.hh \
    src/dict/programs.hh \
    src/dict/romaji.hh \
    src/dict/russiantranslit.hh \
    src/dict/sdict.hh \
    src/dict/slob.hh \
    src/dict/sounddir.hh \
    src/dict/sources.hh \
    src/dict/stardict.hh \
    src/dict/transliteration.hh \
    src/dict/voiceengines.hh \
    src/dict/website.hh \
    src/dict/xdxf.hh \
    src/dict/xdxf2html.hh \
    src/dict/zim.hh \
    src/dict/zipsounds.hh \
    src/dictdfiles.hh \
    src/dictheadwords.hh \
    src/dictinfo.hh \
    src/dictionarybar.hh \
    src/dictserver.hh \
    src/dictspanewidget.hh \
    src/dictzip.hh \
    src/editdictionaries.hh \
    src/ex.hh \
    src/externalaudioplayer.hh \
    src/externalviewer.hh \
    src/favoritespanewidget.hh \
    src/ffmpegaudio.hh \
    src/ffmpegaudioplayer.hh \
    src/file.hh \
    src/filetype.hh \
    src/folding.hh \
    src/fsencoding.hh \
    src/ftshelpers.hh \
    src/fulltextsearch.hh \
    src/gdappstyle.hh \
    src/gddebug.hh \
    src/gestures.hh \
    src/globalbroadcaster.hh \
    src/groupcombobox.hh \
    src/groups.hh \
    src/groups_widgets.hh \
    src/headwordsmodel.hh \
    src/history.hh \
    src/historypanewidget.hh \
    src/hotkeywrapper.hh \
    src/htmlescape.hh \
    src/iconv.hh \
    src/iframeschemehandler.hh \
    src/inc_case_folding.hh \
    src/inc_diacritic_folding.hh \
    src/indexedzip.hh \
    src/initializing.hh \
    src/instances.hh \
    src/keyboardstate.hh \
    src/langcoder.hh \
    src/language.hh \
    src/loaddictionaries.hh \
    src/mainstatusbar.hh \
    src/maintabwidget.hh \
    src/mainwindow.hh \
    src/mdictparser.hh \
    src/mruqmenu.hh \
    src/multimediaaudioplayer.hh \
    src/mutex.hh \
    src/orderandprops.hh \
    src/parsecmdline.hh \
    src/preferences.hh \
    src/resourceschemehandler.hh \
    src/ripemd.hh \
    src/scanpopup.hh \
    src/searchpanewidget.hh \
    src/splitfile.hh \
    src/sptr.hh \
    src/stylescombobox.hh \
    src/termination.hh \
    src/tiff.hh \
    src/translatebox.hh \
    src/ufile.hh \
    src/ui/articleview.hh \
    src/ui/ftssearchpanel.hh \
    src/ui/searchpanel.hh \
    src/utf8.hh \
    src/utils.hh \
    src/webmultimediadownload.hh \
    src/weburlrequestinterceptor.hh \
    src/wordfinder.hh \
    src/wordlist.hh \
    src/wstring.hh \
    src/wstring_qt.hh \
    src/zipfile.hh

FORMS += $$files(src/ui/*.ui)

SOURCES += \
    src/about.cc \
    src/ankiconnector.cc \
    src/article_inspect.cc \
    src/article_maker.cc \
    src/article_netmgr.cc \
    src/articlewebpage.cc \
    src/articlewebview.cc \
    src/atomic_rename.cc \
    src/audiolink.cc \
    src/audioplayerfactory.cc \
    src/base/globalregex.cc \
    src/btreeidx.cc \
    src/chunkedstorage.cc \
    src/config.cc \
    src/country.cc \
    src/decompress.cc \
    src/delegate.cc \
    src/dict/aard.cc \
    src/dict/belarusiantranslit.cc \
    src/dict/bgl.cc \
    src/dict/bgl_babylon.cc \
    src/dict/dictionary.cc \
    src/dict/dsl.cc \
    src/dict/dsl_details.cc \
    src/dict/forvo.cc \
    src/dict/german.cc \
    src/dict/gls.cc \
    src/dict/greektranslit.cc \
    src/dict/hunspell.cc \
    src/dict/lingualibre.cc \
    src/dict/lsa.cc \
    src/dict/mdx.cc \
    src/dict/mediawiki.cc \
    src/dict/programs.cc \
    src/dict/romaji.cc \
    src/dict/russiantranslit.cc \
    src/dict/sdict.cc \
    src/dict/slob.cc \
    src/dict/sounddir.cc \
    src/dict/sources.cc \
    src/dict/stardict.cc \
    src/dict/transliteration.cc \
    src/dict/voiceengines.cc \
    src/dict/website.cc \
    src/dict/xdxf.cc \
    src/dict/xdxf2html.cc \
    src/dict/zim.cc \
    src/dict/zipsounds.cc \
    src/dictdfiles.cc \
    src/dictheadwords.cc \
    src/dictinfo.cc \
    src/dictionarybar.cc \
    src/dictserver.cc \
    src/dictzip.c \
    src/editdictionaries.cc \
    src/externalaudioplayer.cc \
    src/externalviewer.cc \
    src/favoritespanewidget.cc \
    src/ffmpegaudio.cc \
    src/file.cc \
    src/filetype.cc \
    src/folding.cc \
    src/fsencoding.cc \
    src/ftshelpers.cc \
    src/fulltextsearch.cc \
    src/gdappstyle.cc \
    src/gddebug.cc \
    src/gestures.cc \
    src/globalbroadcaster.cc \
    src/groupcombobox.cc \
    src/groups.cc \
    src/groups_widgets.cc \
    src/headwordsmodel.cc \
    src/history.cc \
    src/historypanewidget.cc \
    src/hotkeywrapper.cc \
    src/htmlescape.cc \
    src/iconv.cc \
    src/iframeschemehandler.cc \
    src/indexedzip.cc \
    src/initializing.cc \
    src/instances.cc \
    src/keyboardstate.cc \
    src/langcoder.cc \
    src/language.cc \
    src/loaddictionaries.cc \
    src/main.cc \
    src/mainstatusbar.cc \
    src/maintabwidget.cc \
    src/mainwindow.cc \
    src/mdictparser.cc \
    src/mruqmenu.cc \
    src/multimediaaudioplayer.cc \
    src/mutex.cc \
    src/orderandprops.cc \
    src/parsecmdline.cc \
    src/preferences.cc \
    src/resourceschemehandler.cc \
    src/ripemd.cc \
    src/scanpopup.cc \
    src/splitfile.cc \
    src/stylescombobox.cc \
    src/termination.cc \
    src/tiff.cc \
    src/translatebox.cc \
    src/ufile.cc \
    src/ui/articleview.cc \
    src/ui/ftssearchpanel.cc \
    src/ui/searchpanel.cc \
    src/utf8.cc \
    src/utils.cc \
    src/webmultimediadownload.cc \
    src/weburlrequestinterceptor.cc \
    src/wordfinder.cc \
    src/wordlist.cc \
    src/wstring_qt.cc \
    src/zipfile.cc

#speech to text
SOURCES += src/speechclient.cc \
           src/texttospeechsource.cc
HEADERS += src/texttospeechsource.hh \
           src/speechclient.hh

mac {
    HEADERS += macmouseover.hh \
    src/platform/gd_clipboard.hh
    SOURCES += \
    src/platform/gd_clipboard.cc
}

unix:!mac {
    HEADERS += src/scanflag.hh
    SOURCES += src/scanflag.cc
}


HEADERS += src/wildcard.hh
SOURCES += src/wildcard.cc


CONFIG( zim_support ) {
  DEFINES += MAKE_ZIM_SUPPORT
  LIBS += -llzma -lzstd
}

CONFIG( no_epwing_support ) {
  DEFINES += NO_EPWING_SUPPORT
}

!CONFIG( no_epwing_support ) {
  HEADERS += src/dict/epwing.hh \
             src/dict/epwing_book.hh \
             src/dict/epwing_charmap.hh
  SOURCES += src/dict/epwing.cc \
             src/dict/epwing_book.cc \
             src/dict/epwing_charmap.cc
  LIBS += -leb
}

CONFIG( chinese_conversion_support ) {
  DEFINES += MAKE_CHINESE_CONVERSION_SUPPORT
  FORMS   += src/ui/chineseconversion.ui
  HEADERS += src/dict/chinese.hh \
             src/dict/chineseconversion.hh
  SOURCES += src/dict/chinese.cc \
             src/dict/chineseconversion.cc
  LIBS += -lopencc
}

RESOURCES += resources.qrc \
    scripts.qrc \
    flags.qrc \
    src/stylesheets/css.qrc
#EXTRA_TRANSLATIONS += thirdparty/qwebengine_ts/qtwebengine_zh_CN.ts
TRANSLATIONS += $$files(locale/*.ts)

# Build version file
!isEmpty( hasGit ) {
  PRE_TARGETDEPS      += $$PWD/version.txt
}

# This makes qmake generate translations


isEmpty(QMAKE_LRELEASE):QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease


# The *.qm files might not exist when qmake is run for the first time,
# causing the standard install rule to be ignored, and no translations
# will be installed. With this, we create the qm files during qmake run.
!win32 {
  system($${QMAKE_LRELEASE} -silent $${_PRO_FILE_} 2> /dev/null)
}
else{
  system($${QMAKE_LRELEASE} -silent $${_PRO_FILE_})
}

updateqm.input = TRANSLATIONS
updateqm.output = locale/${QMAKE_FILE_BASE}.qm
updateqm.commands = $$QMAKE_LRELEASE \
    ${QMAKE_FILE_IN} \
    -qm \
    ${QMAKE_FILE_OUT}
updateqm.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += updateqm
TS_OUT = $$TRANSLATIONS
TS_OUT ~= s/.ts/.qm/g
PRE_TARGETDEPS += $$TS_OUT

#QTBUG-105984
# avoid qt6.4.0-6.4.2 .  the qtmultimedia module is buggy in all these versions

include( thirdparty/qtsingleapplication/src/qtsingleapplication.pri )

