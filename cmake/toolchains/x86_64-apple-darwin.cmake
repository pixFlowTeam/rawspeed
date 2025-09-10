# 交叉编译工具链文件 for x86_64-apple-darwin
# 用于 Intel macOS 交叉编译

set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# 指定交叉编译器
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

# 设置目标架构和部署目标
set(CMAKE_OSX_ARCHITECTURES x86_64)
set(CMAKE_OSX_DEPLOYMENT_TARGET "13.5")

# 设置 SDK 路径（如果不在默认位置）
# set(CMAKE_OSX_SYSROOT /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk)

# 搜索路径
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# 设置编译器标志
set(CMAKE_C_FLAGS_INIT "")
set(CMAKE_CXX_FLAGS_INIT "")

# 禁用一些在交叉编译中可能有问题的功能
set(CMAKE_CROSSCOMPILING TRUE)

# 设置目标系统特定的宏
add_definitions(-D__APPLE__)
add_definitions(-D__x86_64__)

# macOS 不支持静态链接 libgcc，只链接 libstdc++
set(CMAKE_EXE_LINKER_FLAGS_INIT "-static-libstdc++")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "-static-libstdc++")

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
