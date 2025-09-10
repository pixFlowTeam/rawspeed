# CMake generated Testfile for 
# Source directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/rawspeed
# Build directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/fuzz/rawspeed
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[fuzzers/RawSpeedFuzzer]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/fuzz/rawspeed/RawSpeedFuzzer" "-help=1")
set_tests_properties([=[fuzzers/RawSpeedFuzzer]=] PROPERTIES  LABELS "fuzz;dummy" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/CMakeLists.txt;31;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/CMakeLists.txt;43;add_fuzz_target__base;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/rawspeed/CMakeLists.txt;3;add_fuzz_target;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/rawspeed/CMakeLists.txt;0;")
