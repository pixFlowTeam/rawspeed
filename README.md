# RawSpeed 跨平台构建

## 概述

RawSpeed 是一个高性能的 RAW 图像解码库，专为快速处理 RAW 文件而设计。本项目提供了跨平台构建支持，可以在 macOS 主机上为多个目标平台进行交叉编译。

## 支持平台

| 平台 | 状态 | 库文件大小 | 编译器 |
|------|------|------------|--------|
| Windows x64 | ✅ | 91MB | MinGW-w64 |
| macOS ARM64 | ✅ | 37MB | AppleClang |
| macOS x64 | ✅ | 36MB | AppleClang |
| Linux x64 | ✅ | 37MB | GCC |

## 快速开始

### 构建所有平台
```bash
cd rawspeed
./scripts/build-unified.sh all
```

### 构建特定平台
```bash
# Windows x64
./scripts/build-unified.sh windows-x64

# macOS ARM64
./scripts/build-unified.sh macos-arm64

# macOS x64
./scripts/build-unified.sh macos-x64

# Linux x64
./scripts/build-unified.sh linux-x64
```

### 清理构建
```bash
# 清理特定平台
./scripts/build-unified.sh windows-x64 --clean

# 清理所有平台
./scripts/build-unified.sh all --clean
```

## 构建配置

### 已禁用功能
- ❌ **OpenMP 支持**: 完全禁用，避免多线程依赖
- ❌ **测试程序**: 所有平台禁用

### 编译器标志

#### Windows x64
```bash
CMAKE_CXX_FLAGS="-w -O2"
CMAKE_C_FLAGS="-w -O2"
```

#### macOS/Linux
```bash
# 使用默认编译器标志
# 无特殊配置
```

## 构建结果

### 库文件位置
```
build/{platform}/lib/
├── librawspeed.a                           # 主库文件
├── librawspeed_get_number_of_processor_cores.a  # 处理器核心检测
└── libpugixml.a                           # XML 解析库
```

### 可执行文件
```
build/{platform}/bin/
└── rawspeed_get_number_of_processor_cores  # 处理器核心检测工具
```

## 依赖要求

### 系统依赖
- **macOS**: Xcode Command Line Tools
- **Windows**: MinGW-w64 (通过 Homebrew 安装)
- **Linux**: 标准开发工具链

### 安装依赖
```bash
# 安装 MinGW-w64 (Windows 交叉编译)
brew install mingw-w64

# 安装 CMake
brew install cmake
```

## 使用方法

### 链接库文件
```cpp
#include <rawspeed/RawSpeed-API.h>

// 链接 librawspeed.a
// 链接 libpugixml.a
// 链接 librawspeed_get_number_of_processor_cores.a
```

### 基本用法
```cpp
using namespace rawspeed;

// 创建 RawSpeed 实例
RawSpeed::RawSpeedAPI api;

// 打开 RAW 文件
auto file = api.openFile("image.raw");

// 解码图像
auto image = api.decode(file);
```

## 故障排除

### 常见问题

1. **Windows 构建失败**
   - 确保安装了 MinGW-w64
   - 检查工具链文件路径

2. **macOS x64 构建失败**
   - 确保创建了正确的工具链文件
   - 检查 Xcode 安装

3. **链接错误**
   - 检查所有必要的库文件
   - 确保链接顺序正确

### 调试命令
```bash
# 查看详细构建日志
make VERBOSE=1

# 检查库文件内容
nm lib/librawspeed.a | head -10
```

## 技术细节

### 库文件说明
- **librawspeed.a**: 主要的 RAW 解码库
- **librawspeed_get_number_of_processor_cores.a**: 处理器核心检测功能
- **libpugixml.a**: XML 解析库，用于处理相机配置文件

### 性能特性
- **高性能**: 专为快速 RAW 解码优化
- **多线程**: 支持多线程解码
- **内存效率**: 优化的内存使用
- **跨平台**: 支持多个操作系统

## 版本信息

- **RawSpeed**: 最新稳定版
- **CMake**: 3.30.6
- **构建日期**: 2024年12月19日

## 许可证

请参考 RawSpeed 项目的原始许可证文件。

---

**注意**: 本文档记录了在 macOS 15.6.0 系统上的构建过程。在其他系统上可能需要调整路径和配置。

