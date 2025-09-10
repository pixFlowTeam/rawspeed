# CMake generated Testfile for 
# Source directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest
# Build directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/utilities/rstest
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[utilities/rstest/md5]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/utilities/rstest/MD5Test")
set_tests_properties([=[utilities/rstest/md5]=] PROPERTIES  LABELS "unittest" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;32;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;0;")
add_test([=[utilities/rstest]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/utilities/rstest/rstest")
set_tests_properties([=[utilities/rstest]=] PROPERTIES  LABELS "dummy" WORKING_DIRECTORY "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/librawspeed/common" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;36;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;0;")
add_test([=[benchmarks/rstest/MD5Benchmark-Dummy]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/utilities/rstest/MD5Benchmark" "--help")
set_tests_properties([=[benchmarks/rstest/MD5Benchmark-Dummy]=] PROPERTIES  LABELS "benchmark;dummy" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;45;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;0;")
add_test([=[benchmarks/rstest/MD5Benchmark]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/src/utilities/rstest/MD5Benchmark" "--benchmark_min_time=1x")
set_tests_properties([=[benchmarks/rstest/MD5Benchmark]=] PROPERTIES  ENVIRONMENT "RAWSPEED_BENCHMARK_DRYRUN=1" LABELS "benchmark" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;51;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/src/utilities/rstest/CMakeLists.txt;0;")
