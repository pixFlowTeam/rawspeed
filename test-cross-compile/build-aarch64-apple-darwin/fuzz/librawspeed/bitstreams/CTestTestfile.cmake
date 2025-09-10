# CMake generated Testfile for 
# Source directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/librawspeed/bitstreams
# Build directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/fuzz/librawspeed/bitstreams
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[fuzzers/BitVacuumerRoundtripFuzzer]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/fuzz/librawspeed/bitstreams/BitVacuumerRoundtripFuzzer" "-help=1")
set_tests_properties([=[fuzzers/BitVacuumerRoundtripFuzzer]=] PROPERTIES  LABELS "fuzz;dummy" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/CMakeLists.txt;31;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/CMakeLists.txt;43;add_fuzz_target__base;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/librawspeed/bitstreams/CMakeLists.txt;5;add_fuzz_target;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/librawspeed/bitstreams/CMakeLists.txt;15;add_simple_fuzzer;/Users/fuguoqiang/Desktop/bridge/rawspeed/fuzz/librawspeed/bitstreams/CMakeLists.txt;0;")
