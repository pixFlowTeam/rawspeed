# Install script for directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
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
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.1.2.11.dylib;/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.1.dylib")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib" TYPE SHARED_LIBRARY FILES
    "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/libz.1.2.11.dylib"
    "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/libz.1.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.1.2.11.dylib"
      "$ENV{DESTDIR}/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.1.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/usr/bin/install_name_tool"
        -id "libz.1.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" -x "${file}")
      endif()
    endif()
  endforeach()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.dylib")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib" TYPE SHARED_LIBRARY FILES "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/libz.dylib")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib" TYPE STATIC_LIBRARY FILES "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/libz.a")
  if(EXISTS "$ENV{DESTDIR}/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.a")
    execute_process(COMMAND "/usr/bin/ranlib" "$ENV{DESTDIR}/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/lib/libz.a")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/include/zconf.h;/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/include/zlib.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/include" TYPE FILE FILES
    "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/zconf.h"
    "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/src/zlib.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/share/man/man3/zlib.3")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/share/man/man3" TYPE FILE FILES "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/src/zlib.3")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/share/pkgconfig/zlib.pc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/install/share/pkgconfig" TYPE FILE FILES "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/external/zlib/build/zlib.pc")
endif()

