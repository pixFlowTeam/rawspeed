#!/bin/bash

# RawSpeed 构建配置管理脚本
# 提供标准化的构建目录管理和配置

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
    echo "RawSpeed 构建配置管理脚本"
    echo ""
    echo "用法: $0 [选项] <命令>"
    echo ""
    echo "命令:"
    echo "  list                   列出所有构建目录"
    echo "  clean [platform]       清理指定平台的构建目录"
    echo "  clean-all              清理所有构建目录"
    echo "  info [platform]        显示指定平台的构建信息"
    echo "  status                 显示构建状态概览"
    echo ""
    echo "选项:"
    echo "  -h, --help             显示此帮助信息"
    echo "  -v, --verbose          详细输出"
    echo ""
    echo "支持的平台:"
    echo "  windows-x64            Windows x64"
    echo "  macos-arm64            macOS ARM64"
    echo "  macos-x64              macOS x64"
    echo "  linux-x64              Linux x64"
    echo ""
    echo "示例:"
    echo "  $0 list"
    echo "  $0 clean windows-x64"
    echo "  $0 clean-all"
    echo "  $0 info macos-arm64"
    echo "  $0 status"
}

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 默认参数
VERBOSE=false
COMMAND=""
PLATFORM=""

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        list|clean|clean-all|info|status)
            COMMAND="$1"
            shift
            ;;
        windows-x64|macos-arm64|macos-x64|linux-x64)
            PLATFORM="$1"
            shift
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

# 获取构建目录名称
get_build_dir() {
    local platform="$1"
    case "$platform" in
        windows-x64)
            echo "build/windows-x64"
            ;;
        macos-arm64)
            echo "build/macos-arm64"
            ;;
        macos-x64)
            echo "build/macos-x64"
            ;;
        linux-x64)
            echo "build/linux-x64"
            ;;
        *)
            echo "build/$platform"
            ;;
    esac
}

# 列出所有构建目录
list_build_dirs() {
    print_info "构建目录列表:"
    echo ""
    
    local found=false
    for pattern in "build-windows-*" "build-macos-*" "build-linux-*" "build-*"; do
        for dir in $PROJECT_ROOT/$pattern; do
            if [[ -d "$dir" ]]; then
                local dirname=$(basename "$dir")
                local size=$(du -sh "$dir" 2>/dev/null | cut -f1 || echo "未知")
                local modified=$(stat -f "%Sm" "$dir" 2>/dev/null || stat -c "%y" "$dir" 2>/dev/null || echo "未知")
                echo "  $dirname ($size, 修改于: $modified)"
                found=true
            fi
        done
    done
    
    if [[ "$found" == false ]]; then
        print_warning "未找到任何构建目录"
    fi
}

# 清理构建目录
clean_build_dir() {
    local platform="$1"
    
    if [[ -z "$platform" ]]; then
        print_error "请指定要清理的平台"
        return 1
    fi
    
    local build_dir="$PROJECT_ROOT/$(get_build_dir "$platform")"
    
    if [[ -d "$build_dir" ]]; then
        print_info "清理构建目录: $build_dir"
        rm -rf "$build_dir"
        print_success "已清理 $platform 构建目录"
    else
        print_warning "构建目录不存在: $build_dir"
    fi
}

# 清理所有构建目录
clean_all_build_dirs() {
    print_info "清理所有构建目录..."
    
    local cleaned=false
    for pattern in "build-windows-*" "build-macos-*" "build-linux-*" "build-*"; do
        for dir in $PROJECT_ROOT/$pattern; do
            if [[ -d "$dir" ]]; then
                local dirname=$(basename "$dir")
                print_info "清理: $dirname"
                rm -rf "$dir"
                cleaned=true
            fi
        done
    done
    
    if [[ "$cleaned" == true ]]; then
        print_success "已清理所有构建目录"
    else
        print_warning "未找到任何构建目录"
    fi
}

# 显示构建信息
show_build_info() {
    local platform="$1"
    
    if [[ -z "$platform" ]]; then
        print_error "请指定平台"
        return 1
    fi
    
    local build_dir="$PROJECT_ROOT/$(get_build_dir "$platform")"
    
    if [[ ! -d "$build_dir" ]]; then
        print_warning "构建目录不存在: $build_dir"
        return 1
    fi
    
    print_info "构建信息 - $platform"
    echo ""
    echo "构建目录: $build_dir"
    echo "大小: $(du -sh "$build_dir" | cut -f1)"
    echo "修改时间: $(stat -f "%Sm" "$build_dir" 2>/dev/null || stat -c "%y" "$build_dir" 2>/dev/null || echo "未知")"
    echo ""
    
    # 显示库文件
    if [[ -d "$build_dir/lib" ]]; then
        echo "库文件:"
        find "$build_dir/lib" -name "*.a" -o -name "*.dll" -o -name "*.dylib" | while read -r file; do
            local filename=$(basename "$file")
            local filesize=$(du -h "$file" | cut -f1)
            echo "  $filename ($filesize)"
        done
        echo ""
    fi
    
    # 显示可执行文件
    if [[ -d "$build_dir/bin" ]]; then
        echo "可执行文件:"
        find "$build_dir/bin" -type f -executable | while read -r file; do
            local filename=$(basename "$file")
            local filesize=$(du -h "$file" | cut -f1)
            echo "  $filename ($filesize)"
        done
        echo ""
    fi
    
    # 显示 CMake 缓存信息
    if [[ -f "$build_dir/CMakeCache.txt" ]]; then
        echo "CMake 配置:"
        grep -E "^(CMAKE_BUILD_TYPE|CMAKE_SYSTEM_NAME|CMAKE_SYSTEM_PROCESSOR|CMAKE_CXX_COMPILER):" "$build_dir/CMakeCache.txt" 2>/dev/null || true
        echo ""
    fi
}

# 显示构建状态概览
show_build_status() {
    print_info "构建状态概览"
    echo ""
    
    local platforms=("windows-x64" "macos-arm64" "macos-x64" "linux-x64")
    local total_size=0
    local count=0
    
    printf "%-15s %-10s %-20s %-10s\n" "平台" "状态" "构建目录" "大小"
    echo "------------------------------------------------------------"
    
    for platform in "${platforms[@]}"; do
        local build_dir="$PROJECT_ROOT/$(get_build_dir "$platform")"
        local status="未构建"
        local size="0B"
        
        if [[ -d "$build_dir" ]]; then
            status="已构建"
            size=$(du -sh "$build_dir" 2>/dev/null | cut -f1 || echo "未知")
            count=$((count + 1))
        fi
        
        printf "%-15s %-10s %-20s %-10s\n" "$platform" "$status" "$(basename "$build_dir")" "$size"
    done
    
    echo "------------------------------------------------------------"
    echo "总计: $count/4 个平台已构建"
    
    if [[ $count -gt 0 ]]; then
        echo ""
        print_info "可用的构建目录:"
        for platform in "${platforms[@]}"; do
            local build_dir="$PROJECT_ROOT/$(get_build_dir "$platform")"
            if [[ -d "$build_dir" ]]; then
                echo "  $platform: $build_dir"
            fi
        done
    fi
}

# 执行命令
case "$COMMAND" in
    list)
        list_build_dirs
        ;;
    clean)
        clean_build_dir "$PLATFORM"
        ;;
    clean-all)
        clean_all_build_dirs
        ;;
    info)
        show_build_info "$PLATFORM"
        ;;
    status)
        show_build_status
        ;;
    *)
        print_error "未知命令: $COMMAND"
        show_help
        exit 1
        ;;
esac
