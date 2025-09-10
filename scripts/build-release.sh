#!/bin/bash

# RawSpeed 独立发布构建脚本
# 支持多平台交叉编译和依赖管理

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_success() {
    echo -e "${BLUE}[SUCCESS]${NC} $1"
}

# 显示帮助信息
show_help() {
    echo "RawSpeed 独立发布构建脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help          显示此帮助信息"
    echo "  -p, --platforms     指定要编译的平台 (用逗号分隔)"
    echo "  -c, --clean         清理所有构建目录"
    echo "  -j, --jobs N        并行编译任务数 (默认: 4)"
    echo "  -o, --output DIR    输出目录 (默认: ./release)"
    echo "  -v, --verbose       详细输出"
    echo "  --all               编译所有支持的平台"
    echo ""
    echo "支持的平台:"
    echo "  windows-x64         Windows x64 (x86_64-w64-mingw32)"
    echo "  macos-arm64         macOS ARM64 (aarch64-apple-darwin)"
    echo "  macos-x64           macOS x64 (x86_64-apple-darwin)"
    echo "  linux-x64           Linux x64 (native)"
    echo ""
    echo "示例:"
    echo "  $0 --all"
    echo "  $0 --platforms windows-x64,macos-arm64"
    echo "  $0 --clean --all --jobs 8"
}

# 默认参数
PLATFORMS=""
CLEAN_ALL=false
JOBS=4
OUTPUT_DIR="./release"
VERBOSE=false
BUILD_ALL=false

# 支持的平台列表
SUPPORTED_PLATFORMS=("windows-x64" "macos-arm64" "macos-x64" "linux-x64")

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -p|--platforms)
            PLATFORMS="$2"
            shift 2
            ;;
        -c|--clean)
            CLEAN_ALL=true
            shift
            ;;
        -j|--jobs)
            JOBS="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --all)
            BUILD_ALL=true
            shift
            ;;
        *)
            print_error "未知参数: $1"
            show_help
            exit 1
            ;;
    esac
done

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

print_info "项目根目录: $PROJECT_ROOT"

# 设置要编译的平台
if [[ "$BUILD_ALL" == true ]]; then
    PLATFORMS="windows-x64,macos-arm64,macos-x64,linux-x64"
fi

if [[ -z "$PLATFORMS" ]]; then
    print_error "请指定要编译的平台或使用 --all"
    show_help
    exit 1
fi

# 解析平台列表
IFS=',' read -ra PLATFORM_ARRAY <<< "$PLATFORMS"

# 验证平台
for platform in "${PLATFORM_ARRAY[@]}"; do
    if [[ ! " ${SUPPORTED_PLATFORMS[@]} " =~ " ${platform} " ]]; then
        print_error "不支持的平台: $platform"
        print_info "支持的平台: ${SUPPORTED_PLATFORMS[*]}"
        exit 1
    fi
done

# 清理所有构建目录
if [[ "$CLEAN_ALL" == true ]]; then
    print_info "清理所有构建目录..."
    rm -rf "$PROJECT_ROOT/build"
    rm -rf "$OUTPUT_DIR"
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 编译函数
build_platform() {
    local platform="$1"
    local build_dir
    
    # 使用标准构建目录命名，放在 build 目录下
    case "$platform" in
        windows-x64)
            build_dir="$PROJECT_ROOT/build/windows-x64"
            ;;
        macos-arm64)
            build_dir="$PROJECT_ROOT/build/macos-arm64"
            ;;
        macos-x64)
            build_dir="$PROJECT_ROOT/build/macos-x64"
            ;;
        linux-x64)
            build_dir="$PROJECT_ROOT/build/linux-x64"
            ;;
        *)
            build_dir="$PROJECT_ROOT/build/$platform"
            ;;
    esac
    
    print_info "开始编译平台: $platform"
    
    # 创建构建目录
    mkdir -p "$build_dir"
    cd "$build_dir"
    
    # 根据平台设置 CMake 参数
    case "$platform" in
        windows-x64)
            # 检查 MinGW-w64
            if ! command -v x86_64-w64-mingw32-gcc &> /dev/null; then
                print_error "未找到 x86_64-w64-mingw32-gcc，请安装 MinGW-w64"
                return 1
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
            # 检查 Xcode
            if ! command -v clang &> /dev/null; then
                print_error "未找到 clang，请安装 Xcode Command Line Tools"
                return 1
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
            
        macos-x64)
            # 检查 Xcode
            if ! command -v clang &> /dev/null; then
                print_error "未找到 clang，请安装 Xcode Command Line Tools"
                return 1
            fi
            
            CMAKE_ARGS=(
                -DCMAKE_OSX_ARCHITECTURES=x86_64
                -DCMAKE_OSX_DEPLOYMENT_TARGET=13.5
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
            
        linux-x64)
            # 检查 GCC
            if ! command -v gcc &> /dev/null; then
                print_error "未找到 gcc，请安装 GCC"
                return 1
            fi
            
            CMAKE_ARGS=(
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
    
    # 运行 CMake 配置
    print_info "配置 $platform..."
    cmake "${CMAKE_ARGS[@]}" "$PROJECT_ROOT"
    
    # 编译
    print_info "编译 $platform (使用 $JOBS 个并行任务)..."
    make -j"$JOBS"
    
    # 复制文件到输出目录
    local platform_output_dir="$OUTPUT_DIR/$platform"
    mkdir -p "$platform_output_dir"
    
    # 复制库文件
    if [[ -d "lib" ]]; then
        cp -r lib/* "$platform_output_dir/"
    fi
    
    # 复制可执行文件
    if [[ -d "bin" ]]; then
        cp -r bin/* "$platform_output_dir/"
    fi
    
    # 复制头文件
    mkdir -p "$platform_output_dir/include"
    cp -r "$PROJECT_ROOT/src/librawspeed"/*.h "$platform_output_dir/include/" 2>/dev/null || true
    
    print_success "平台 $platform 编译完成"
}

# 编译所有平台
for platform in "${PLATFORM_ARRAY[@]}"; do
    build_platform "$platform"
done

# 创建发布包
print_info "创建发布包..."

# 创建 README
cat > "$OUTPUT_DIR/README.md" << EOF
# RawSpeed 独立发布包

这是 RawSpeed 库的独立发布包，包含所有必要的依赖项。

## 支持的平台

$(for platform in "${PLATFORM_ARRAY[@]}"; do
    echo "- $platform"
done)

## 文件结构

\`\`\`
release/
├── README.md
$(for platform in "${PLATFORM_ARRAY[@]}"; do
    echo "├── $platform/"
    echo "│   ├── include/     # 头文件"
    echo "│   ├── librawspeed.a  # 主库文件"
    echo "│   └── ...          # 其他库文件"
done)
\`\`\`

## 使用方法

1. 将对应平台的库文件链接到你的项目中
2. 包含头文件目录
3. 确保链接所有依赖库

## 依赖项

所有依赖项都已静态链接，无需额外安装：
- OpenMP (LLVM OpenMP)
- Pugixml
- ZLIB

## 编译信息

- 编译时间: $(date)
- 编译器版本: $(gcc --version 2>/dev/null | head -n1 || clang --version 2>/dev/null | head -n1 || echo "未知")
- CMake 版本: $(cmake --version | head -n1)
EOF

# 创建压缩包
print_info "创建压缩包..."
cd "$OUTPUT_DIR"
tar -czf "../rawspeed-release-$(date +%Y%m%d).tar.gz" .
cd "$PROJECT_ROOT"

print_success "发布包创建完成: rawspeed-release-$(date +%Y%m%d).tar.gz"
print_info "输出目录: $OUTPUT_DIR"

# 显示文件大小
print_info "各平台文件大小:"
for platform in "${PLATFORM_ARRAY[@]}"; do
    if [[ -d "$OUTPUT_DIR/$platform" ]]; then
        size=$(du -sh "$OUTPUT_DIR/$platform" | cut -f1)
        print_info "  $platform: $size"
    fi
done
