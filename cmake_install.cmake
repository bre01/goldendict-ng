# Install script for directory: /Users/bre/code/goldendict-ng

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Applications/Xcode-16.3.0.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/bre/code/goldendict-ng/redist" TYPE DIRECTORY FILES "/Users/bre/code/goldendict-ng/GoldenDict-ng.app" USE_SOURCE_PERMISSIONS)
  if(EXISTS "$ENV{DESTDIR}/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/GoldenDict-ng" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/GoldenDict-ng")
    execute_process(COMMAND /usr/bin/install_name_tool
      -delete_rpath "/Users/bre/Qt/6.8.3/macos/lib"
      -add_rpath "@executable_path/../Frameworks"
      "$ENV{DESTDIR}/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/GoldenDict-ng")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ar_SA.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ay_BO.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/be_BY.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/bg_BG.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/crowdin.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/cs_CZ.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/de_CH.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/de_DE.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/el_GR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/eo_UY.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/es_AR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/es_BO.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/es_ES.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/fa_IR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/fi_FI.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/fr_FR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/hi_IN.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/hu_HU.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ie_001.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/it_IT.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ja_JP.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/jbo_EN.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/kab_KAB.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ko_KR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/lt_LT.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/mk_MK.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/nl_NL.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/pl_PL.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/pt_BR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/pt_PT.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/qu_PE.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/ru_RU.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/sk_SK.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/sq_AL.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/sr_SP.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/sv_SE.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/tg_TJ.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/tk_TM.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/tr_TR.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/uk_UA.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/vi_VN.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/zh_CN.qm;/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale/zh_TW.qm")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/locale" TYPE FILE FILES
    "/Users/bre/code/goldendict-ng/locale/ar_SA.qm"
    "/Users/bre/code/goldendict-ng/locale/ay_BO.qm"
    "/Users/bre/code/goldendict-ng/locale/be_BY.qm"
    "/Users/bre/code/goldendict-ng/locale/bg_BG.qm"
    "/Users/bre/code/goldendict-ng/locale/crowdin.qm"
    "/Users/bre/code/goldendict-ng/locale/cs_CZ.qm"
    "/Users/bre/code/goldendict-ng/locale/de_CH.qm"
    "/Users/bre/code/goldendict-ng/locale/de_DE.qm"
    "/Users/bre/code/goldendict-ng/locale/el_GR.qm"
    "/Users/bre/code/goldendict-ng/locale/eo_UY.qm"
    "/Users/bre/code/goldendict-ng/locale/es_AR.qm"
    "/Users/bre/code/goldendict-ng/locale/es_BO.qm"
    "/Users/bre/code/goldendict-ng/locale/es_ES.qm"
    "/Users/bre/code/goldendict-ng/locale/fa_IR.qm"
    "/Users/bre/code/goldendict-ng/locale/fi_FI.qm"
    "/Users/bre/code/goldendict-ng/locale/fr_FR.qm"
    "/Users/bre/code/goldendict-ng/locale/hi_IN.qm"
    "/Users/bre/code/goldendict-ng/locale/hu_HU.qm"
    "/Users/bre/code/goldendict-ng/locale/ie_001.qm"
    "/Users/bre/code/goldendict-ng/locale/it_IT.qm"
    "/Users/bre/code/goldendict-ng/locale/ja_JP.qm"
    "/Users/bre/code/goldendict-ng/locale/jbo_EN.qm"
    "/Users/bre/code/goldendict-ng/locale/kab_KAB.qm"
    "/Users/bre/code/goldendict-ng/locale/ko_KR.qm"
    "/Users/bre/code/goldendict-ng/locale/lt_LT.qm"
    "/Users/bre/code/goldendict-ng/locale/mk_MK.qm"
    "/Users/bre/code/goldendict-ng/locale/nl_NL.qm"
    "/Users/bre/code/goldendict-ng/locale/pl_PL.qm"
    "/Users/bre/code/goldendict-ng/locale/pt_BR.qm"
    "/Users/bre/code/goldendict-ng/locale/pt_PT.qm"
    "/Users/bre/code/goldendict-ng/locale/qu_PE.qm"
    "/Users/bre/code/goldendict-ng/locale/ru_RU.qm"
    "/Users/bre/code/goldendict-ng/locale/sk_SK.qm"
    "/Users/bre/code/goldendict-ng/locale/sq_AL.qm"
    "/Users/bre/code/goldendict-ng/locale/sr_SP.qm"
    "/Users/bre/code/goldendict-ng/locale/sv_SE.qm"
    "/Users/bre/code/goldendict-ng/locale/tg_TJ.qm"
    "/Users/bre/code/goldendict-ng/locale/tk_TM.qm"
    "/Users/bre/code/goldendict-ng/locale/tr_TR.qm"
    "/Users/bre/code/goldendict-ng/locale/uk_UA.qm"
    "/Users/bre/code/goldendict-ng/locale/vi_VN.qm"
    "/Users/bre/code/goldendict-ng/locale/zh_CN.qm"
    "/Users/bre/code/goldendict-ng/locale/zh_TW.qm"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS/opencc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app/Contents/MacOS" TYPE DIRECTORY FILES "/opt/homebrew/Cellar/opencc/1.1.9/share/opencc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  include("/Users/bre/code/goldendict-ng/.qt/deploy_GoldenDict_ng_b9955d1ff5.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND codesign --force --deep -s - /Users/bre/code/goldendict-ng/redist/GoldenDict-ng.app)
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/bre/code/goldendict-ng/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/bre/code/goldendict-ng/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
