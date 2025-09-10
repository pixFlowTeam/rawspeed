#!/bin/bash

# RawSpeed 交叉编译脚本
# 支持 x86_64-w64-mingw32 和 aarch64-apple-darwin

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印函数
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 显示帮助信息
show_help() {
    echo "RawSpeed 交叉编译脚本"
    echo ""
    echo "用法: $0 [选项] <目标平台>"
    echo ""
    echo "目标平台:"
    echo "  windows-x64    编译 Windows x64 版本 (x86_64-w64-mingw32)"
    echo "  macos-arm64    编译 macOS ARM64 版本 (aarch64-apple-darwin)"
    echo ""
    echo "选项:"
    echo "  -h, --help     显示此帮助信息"
    echo "  -c, --clean    清理构建目录"
    echo "  -j, --jobs N   并行编译任务数 (默认: 4)"
    echo "  -v, --verbose  详细输出"
    echo ""
    echo "示例:"
    echo "  $0 windows-x64"
    echo "  $0 macos-arm64 --clean"
    echo "  $0 windows-x64 --jobs 8 --verbose"
}

# 默认参数
TARGET_PLATFORM=""
CLEAN_BUILD=false
JOBS=4
VERBOSE=false

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -c|--clean)
            CLEAN_BUILD=true
            shift
            ;;
        -j|--jobs)
            JOBS="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        windows-x64|macos-arm64)
            TARGET_PLATFORM="$1"
            shift
            ;;
        *)
            print_error "未知参数: $1"
            show_help
            exit 1
            ;;
    esac
done

# 检查目标平台
if [[ -z "$TARGET_PLATFORM" ]]; then
    print_error "请指定目标平台"
    show_help
    exit 1
fi

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

print_info "项目根目录: $PROJECT_ROOT"

# 设置构建目录 - 使用标准命名规范
case "$TARGET_PLATFORM" in
    windows-x64)
        BUILD_DIR="$PROJECT_ROOT/build-windows-x64"
        ;;
    macos-arm64)
        BUILD_DIR="$PROJECT_ROOT/build-macos-arm64"
        ;;
    macos-x64)
        BUILD_DIR="$PROJECT_ROOT/build-macos-x64"
        ;;
    linux-x64)
        BUILD_DIR="$PROJECT_ROOT/build-linux-x64"
        ;;
    *)
        BUILD_DIR="$PROJECT_ROOT/build-$TARGET_PLATFORM"
        ;;
esac

# 清理构建目录
if [[ "$CLEAN_BUILD" == true ]]; then
    print_info "清理构建目录: $BUILD_DIR"
    rm -rf "$BUILD_DIR"
fi

# 创建构建目录
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# 根据目标平台设置参数
case "$TARGET_PLATFORM" in
    windows-x64)
        print_info "配置 Windows x64 交叉编译..."
        
        # 检查 MinGW-w64 是否安装
        if ! command -v x86_64-w64-mingw32-gcc &> /dev/null; then
            print_error "未找到 x86_64-w64-mingw32-gcc，请安装 MinGW-w64"
            print_info "在 macOS 上: brew install mingw-w64"
            print_info "在 Ubuntu 上: sudo apt-get install gcc-mingw-w64-x86-64"
            exit 1
        fi
        
        CMAKE_ARGS=(
            -DCMAKE_TOOLCHAIN_FILE="$PROJECT_ROOT/cmake/toolchains/x86_64-w64-mingw32.cmake"
            -DCMAKE_BUILD_TYPE=Release
            -DBINARY_PACKAGE_BUILD=ON
            -DWITH_OPENMP=OFF
            -DWITH_PUGIXML=ON
            -DUSE_BUNDLED_PUGIXML=ON
            -DALLOW_DOWNLOADING_PUGIXML=ON
            -DWITH_ZLIB=OFF
            -DWITH_JPEG=OFF
            -DBUILD_TESTING=OFF
            -DBUILD_BENCHMARKING=OFF
            -DBUILD_DOCS=OFF
            -DBUILD_FUZZERS=OFF
            -DBUILD_TOOLS=OFF
            -DRAWSPEED_ENABLE_WERROR=OFF
            -DRAWSPEED_ENABLE_CLANG_TIDY_WERROR=OFF
        )
        ;;
        
    macos-arm64)
        print_info "配置 macOS ARM64 交叉编译..."
        
        # 检查 Xcode 是否安装
        if ! command -v clang &> /dev/null; then
            print_error "未找到 clang，请安装 Xcode Command Line Tools"
            print_info "运行: xcode-select --install"
            exit 1
        fi
        
        CMAKE_ARGS=(
            -DCMAKE_TOOLCHAIN_FILE="$PROJECT_ROOT/cmake/toolchains/aarch64-apple-darwin.cmake"
            -DCMAKE_BUILD_TYPE=Release
            -DBINARY_PACKAGE_BUILD=ON
            -DWITH_OPENMP=OFF
            -DWITH_PUGIXML=ON
            -DUSE_BUNDLED_PUGIXML=ON
            -DALLOW_DOWNLOADING_PUGIXML=ON
            -DWITH_ZLIB=OFF
            -DWITH_JPEG=OFF
            -DBUILD_TESTING=OFF
            -DBUILD_BENCHMARKING=OFF
            -DBUILD_DOCS=OFF
            -DBUILD_FUZZERS=OFF
            -DBUILD_TOOLS=OFF
            -DRAWSPEED_ENABLE_WERROR=OFF
            -DRAWSPEED_ENABLE_CLANG_TIDY_WERROR=OFF
        )
        ;;
esac

# 添加详细输出选项
if [[ "$VERBOSE" == true ]]; then
    CMAKE_ARGS+=(-DCMAKE_VERBOSE_MAKEFILE=ON)
fi

print_info "CMake 配置参数:"
for arg in "${CMAKE_ARGS[@]}"; do
    echo "  $arg"
done

# 运行 CMake 配置
print_info "运行 CMake 配置..."
cmake "${CMAKE_ARGS[@]}" "$PROJECT_ROOT"

# 编译
print_info "开始编译 (使用 $JOBS 个并行任务)..."
make -j"$JOBS"

print_info "编译完成！"
print_info "构建目录: $BUILD_DIR"
print_info "库文件位置: $BUILD_DIR/lib/"
print_info "可执行文件位置: $BUILD_DIR/bin/"

# 显示生成的文件
print_info "生成的文件:"
find "$BUILD_DIR" -name "*.a" -o -name "*.dll" -o -name "*.exe" -o -name "*.dylib" | while read -r file; do
    echo "  $file"
done
