# RawSpeed 独立发布配置
# 用于创建不依赖系统库的独立发布包

# 设置独立发布模式
set(RAWSPEED_STANDALONE_RELEASE TRUE)

# 强制使用所有依赖的内置版本
set(USE_BUNDLED_LLVMOPENMP ON CACHE BOOL "Force bundled OpenMP" FORCE)
set(USE_BUNDLED_PUGIXML ON CACHE BOOL "Force bundled Pugixml" FORCE)
set(USE_BUNDLED_ZLIB ON CACHE BOOL "Force bundled ZLIB" FORCE)

# 禁用可选功能以减少依赖
set(WITH_JPEG OFF CACHE BOOL "Disable JPEG support" FORCE)
set(BUILD_TESTING OFF CACHE BOOL "Disable testing" FORCE)
set(BUILD_BENCHMARKING OFF CACHE BOOL "Disable benchmarking" FORCE)
set(BUILD_DOCS OFF CACHE BOOL "Disable documentation" FORCE)
set(BUILD_FUZZERS OFF CACHE BOOL "Disable fuzzing" FORCE)
set(BUILD_TOOLS OFF CACHE BOOL "Disable tools" FORCE)

# 禁用警告错误以简化交叉编译
set(RAWSPEED_ENABLE_WERROR OFF CACHE BOOL "Disable warnings as errors" FORCE)
set(RAWSPEED_ENABLE_CLANG_TIDY_WERROR OFF CACHE BOOL "Disable clang-tidy errors" FORCE)

# 启用二进制包构建模式
set(BINARY_PACKAGE_BUILD ON CACHE BOOL "Enable binary package build" FORCE)

# 设置静态链接
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

# 针对不同平台的特定设置
if(WIN32)
    # Windows 特定设置
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static-libgcc")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -static")
    
    # Windows 特定宏
    add_definitions(-D_WIN32_WINNT=0x0601)
    add_definitions(-DWIN32_LEAN_AND_MEAN)
    add_definitions(-DNOMINMAX)
    
elseif(APPLE)
    # macOS 特定设置
    if(CMAKE_OSX_ARCHITECTURES MATCHES "arm64")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -arch arm64")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -arch arm64")
    elseif(CMAKE_OSX_ARCHITECTURES MATCHES "x86_64")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -arch x86_64")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -arch x86_64")
    endif()
    
    # 设置最低部署目标
    if(NOT CMAKE_OSX_DEPLOYMENT_TARGET)
        set(CMAKE_OSX_DEPLOYMENT_TARGET "13.5")
    endif()
    
    # macOS 特定宏
    add_definitions(-D__APPLE__)
    
elseif(UNIX)
    # Linux 特定设置
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static-libgcc")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++")
endif()

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# 禁用一些在交叉编译中可能有问题的功能
set(CMAKE_DISABLE_FIND_PACKAGE_JPEG TRUE)
set(CMAKE_DISABLE_FIND_PACKAGE_PkgConfig TRUE)

# 设置编译器特定的优化
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG")
endif()

# 消息输出
message(STATUS "RawSpeed 独立发布模式已启用")
message(STATUS "目标平台: ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "编译器: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "构建类型: ${CMAKE_BUILD_TYPE}")
message(STATUS "使用内置依赖: OpenMP, Pugixml, ZLIB")
