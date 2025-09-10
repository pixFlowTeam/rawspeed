# CMake generated Testfile for 
# Source directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/interpolators
# Build directory: /Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/bench/librawspeed/interpolators
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[Cr2sRawInterpolatorBenchmark-Dummy]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/bench/librawspeed/interpolators/Cr2sRawInterpolatorBenchmark" "--help")
set_tests_properties([=[Cr2sRawInterpolatorBenchmark-Dummy]=] PROPERTIES  LABELS "benchmark;dummy" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/CMakeLists.txt;18;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/interpolators/CMakeLists.txt;6;add_rs_bench;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/interpolators/CMakeLists.txt;0;")
add_test([=[Cr2sRawInterpolatorBenchmark]=] "/Users/fuguoqiang/Desktop/bridge/rawspeed/test-cross-compile/build-aarch64-apple-darwin/bench/librawspeed/interpolators/Cr2sRawInterpolatorBenchmark" "--benchmark_min_time=1x")
set_tests_properties([=[Cr2sRawInterpolatorBenchmark]=] PROPERTIES  ENVIRONMENT "RAWSPEED_BENCHMARK_DRYRUN=1" LABELS "benchmark" _BACKTRACE_TRIPLES "/Users/fuguoqiang/Desktop/bridge/rawspeed/cmake/cmake-command-wrappers.cmake;19;add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/CMakeLists.txt;24;rawspeed_add_test;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/interpolators/CMakeLists.txt;6;add_rs_bench;/Users/fuguoqiang/Desktop/bridge/rawspeed/bench/librawspeed/interpolators/CMakeLists.txt;0;")
