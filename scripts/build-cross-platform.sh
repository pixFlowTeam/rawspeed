#!/bin/bash

# RawSpeed 跨平台构建脚本
# 统一的构建接口，支持所有平台

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
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

print_header() {
    echo -e "${CYAN}================================${NC}"
    echo -e "${CYAN}  RawSpeed 跨平台构建工具${NC}"
    echo -e "${CYAN}================================${NC}"
    echo ""
}

# 显示帮助信息
show_help() {
    print_header
    echo "用法: $0 [命令] [选项]"
    echo ""
    echo "命令:"
    echo "  all                   构建所有支持的平台"
    echo "  windows               构建 Windows x64"
    echo "  macos                 构建 macOS (ARM64 + x64)"
    echo "  macos-arm64          构建 macOS ARM64"
    echo "  macos-x64            构建 macOS x64"
    echo "  linux                构建 Linux x64"
    echo "  clean                清理所有构建目录"
    echo "  status               显示构建状态"
    echo "  help                 显示此帮助信息"
    echo ""
    echo "选项:"
    echo "  --jobs N             并行编译任务数 (默认: 4)"
    echo "  --verbose            详细输出"
    echo "  --debug              调试构建"
    echo "  --release            发布构建 (默认)"
    echo ""
    echo "示例:"
    echo "  $0 all                           # 构建所有平台"
    echo "  $0 windows --jobs 8              # 构建 Windows，使用 8 个并行任务"
    echo "  $0 macos --verbose               # 构建 macOS，详细输出"
    echo "  $0 clean                         # 清理所有构建目录"
    echo "  $0 status                        # 显示构建状态"
    echo ""
    echo "支持的平台:"
    echo "  - Windows x64 (x86_64-w64-mingw32)"
    echo "  - macOS ARM64 (aarch64-apple-darwin)"
    echo "  - macOS x64 (x86_64-apple-darwin)"
    echo "  - Linux x64 (native)"
}

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 默认参数
COMMAND=""
JOBS=4
VERBOSE=false
BUILD_TYPE="Release"
CLEAN_BUILD=false

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        all|windows|macos|macos-arm64|macos-x64|linux|clean|status|help)
            COMMAND="$1"
            shift
            ;;
        --jobs)
            JOBS="$2"
            shift 2
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --debug)
            BUILD_TYPE="Debug"
            shift
            ;;
        --release)
            BUILD_TYPE="Release"
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "未知参数: $1"
            show_help
            exit 1
            ;;
    esac
done

# 检查命令
if [[ -z "$COMMAND" ]]; then
    print_error "请指定命令"
    show_help
    exit 1
fi

# 显示帮助
if [[ "$COMMAND" == "help" ]]; then
    show_help
    exit 0
fi

# 构建单个平台
build_platform() {
    local platform="$1"
    local extra_args=()
    
    if [[ "$VERBOSE" == true ]]; then
        extra_args+=(--verbose)
    fi
    
    if [[ "$BUILD_TYPE" == "Debug" ]]; then
        extra_args+=(--debug)
    fi
    
    extra_args+=(--jobs "$JOBS")
    
    print_info "开始构建平台: $platform"
    echo ""
    
    if ! "$SCRIPT_DIR/build.sh" "$platform" "${extra_args[@]}"; then
        print_error "平台 $platform 构建失败"
        return 1
    fi
    
    print_success "平台 $platform 构建完成"
    echo ""
}

# 清理所有构建目录
clean_all() {
    print_info "清理所有构建目录..."
    
    if [[ -d "$PROJECT_ROOT/build" ]]; then
        rm -rf "$PROJECT_ROOT/build"
        print_success "已清理 build/ 目录"
    else
        print_warning "build/ 目录不存在"
    fi
    
    # 清理旧的构建目录（如果存在）
    local old_dirs=("build-windows-x64" "build-macos-arm64" "build-macos-x64" "build-linux-x64")
    for dir in "${old_dirs[@]}"; do
        if [[ -d "$PROJECT_ROOT/$dir" ]]; then
            rm -rf "$PROJECT_ROOT/$dir"
            print_success "已清理旧目录: $dir"
        fi
    done
}

# 显示构建状态
show_status() {
    print_info "构建状态概览"
    echo ""
    
    local platforms=("windows-x64" "macos-arm64" "macos-x64" "linux-x64")
    local total_size=0
    local built_count=0
    
    printf "%-15s %-10s %-20s %-10s\n" "平台" "状态" "构建目录" "大小"
    echo "------------------------------------------------------------"
    
    for platform in "${platforms[@]}"; do
        local build_dir="$PROJECT_ROOT/build/$platform"
        local status="未构建"
        local size="0B"
        
        if [[ -d "$build_dir" ]]; then
            status="已构建"
            size=$(du -sh "$build_dir" 2>/dev/null | cut -f1 || echo "未知")
            built_count=$((built_count + 1))
        fi
        
        printf "%-15s %-10s %-20s %-10s\n" "$platform" "$status" "build/$platform" "$size"
    done
    
    echo "------------------------------------------------------------"
    echo "总计: $built_count/${#platforms[@]} 个平台已构建"
    echo ""
    
    # 显示可用的构建目录
    if [[ $built_count -gt 0 ]]; then
        print_info "可用的构建目录:"
        for platform in "${platforms[@]}"; do
            local build_dir="$PROJECT_ROOT/build/$platform"
            if [[ -d "$build_dir" ]]; then
                echo "  $platform: $build_dir"
            fi
        done
    fi
}

# 主逻辑
case "$COMMAND" in
    all)
        print_header
        print_info "开始构建所有支持的平台..."
        echo ""
        
        # 构建所有平台
        build_platform "windows-x64" || true
        build_platform "macos-arm64" || true
        build_platform "macos-x64" || true
        build_platform "linux-x64" || true
        
        echo ""
        print_success "所有平台构建完成！"
        show_status
        ;;
        
    windows)
        print_header
        build_platform "windows-x64"
        ;;
        
    macos)
        print_header
        print_info "构建 macOS 平台 (ARM64 + x64)..."
        echo ""
        build_platform "macos-arm64"
        build_platform "macos-x64"
        ;;
        
    macos-arm64)
        print_header
        build_platform "macos-arm64"
        ;;
        
    macos-x64)
        print_header
        build_platform "macos-x64"
        ;;
        
    linux)
        print_header
        build_platform "linux-x64"
        ;;
        
    clean)
        print_header
        clean_all
        ;;
        
    status)
        print_header
        show_status
        ;;
        
    *)
        print_error "未知命令: $COMMAND"
        show_help
        exit 1
        ;;
esac
