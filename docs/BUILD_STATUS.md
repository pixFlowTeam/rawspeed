# RawSpeed 构建状态

本文档记录 RawSpeed 项目的跨平台构建支持状态和最新信息。

## 📊 构建状态概览

| 平台 | 架构 | 状态 | 构建方式 | 工具链 | 测试状态 |
|------|------|------|----------|--------|----------|
| **Windows** | x64 | ✅ 支持 | 交叉编译 | MinGW-w64 | ✅ 已测试 |
| **macOS** | ARM64 | ✅ 支持 | 交叉编译 | Apple Clang | ✅ 已测试 |
| **macOS** | x64 | ✅ 支持 | 原生编译 | Apple Clang | ✅ 已测试 |
| **Linux** | x64 | ✅ 支持 | 原生编译 | GCC/Clang | ✅ 已测试 |

## 🎯 支持的功能

### ✅ 已实现功能

- **跨平台构建** - 支持 Windows、macOS、Linux
- **独立发布** - 不依赖系统库，使用捆绑依赖
- **标准目录结构** - 使用 `build/<platform>-<arch>/` 命名
- **统一构建脚本** - 提供简洁的构建接口
- **CI/CD 支持** - GitHub Actions 自动构建
- **详细文档** - 完整的构建和使用指南

### 🔧 构建特性

- **静态链接** - 生成的库文件是静态的，便于分发
- **捆绑依赖** - 自动下载和构建 pugixml 等依赖
- **错误处理** - 完善的错误检查和回退机制
- **并行构建** - 支持多线程并行编译
- **清理功能** - 支持清理构建目录和重新构建

## 📁 构建目录结构

```
build/
├── windows-x64/     # Windows x64 构建
│   ├── lib/
│   │   ├── librawspeed.a
│   │   ├── librawspeed_get_number_of_processor_cores.a
│   │   └── libpugixml.a
│   └── bin/
├── macos-arm64/     # macOS ARM64 构建
│   ├── lib/
│   │   ├── librawspeed.a
│   │   ├── librawspeed_get_number_of_processor_cores.a
│   │   └── libpugixml.a
│   └── bin/
├── macos-x64/       # macOS x64 构建
│   ├── lib/
│   │   ├── librawspeed.a
│   │   ├── librawspeed_get_number_of_processor_cores.a
│   │   └── libpugixml.a
│   └── bin/
└── linux-x64/       # Linux x64 构建
    ├── lib/
    │   ├── librawspeed.a
    │   ├── librawspeed_get_number_of_processor_cores.a
    │   └── libpugixml.a
    └── bin/
```

## 🚀 快速开始

### 构建所有平台

```bash
./scripts/build-cross-platform.sh all
```

### 构建特定平台

```bash
# Windows x64
./scripts/build-cross-platform.sh windows

# macOS (ARM64 + x64)
./scripts/build-cross-platform.sh macos

# Linux x64
./scripts/build-cross-platform.sh linux
```

### 查看构建状态

```bash
./scripts/build-cross-platform.sh status
```

## 📋 系统要求

### Windows 交叉编译
- **主机**: macOS 或 Linux
- **工具链**: MinGW-w64
- **依赖**: 自动下载

### macOS 构建
- **主机**: macOS
- **工具链**: Xcode Command Line Tools
- **依赖**: 自动下载

### Linux 构建
- **主机**: Linux (Ubuntu、CentOS、RHEL、Debian、Fedora 等)
- **工具链**: GCC 7.0+ 或 Clang 6.0+
- **依赖**: 自动下载

## 🔧 构建脚本

| 脚本 | 用途 | 推荐度 | 特点 |
|------|------|--------|------|
| `build-cross-platform.sh` | 统一构建脚本 | ⭐⭐⭐⭐⭐ | 简单易用，支持所有平台 |
| `build.sh` | 单个平台构建 | ⭐⭐⭐⭐ | 精确控制，开发友好 |
| `build-release.sh` | 发布构建 | ⭐⭐⭐ | 批量构建，发布管理 |
| `build-config.sh` | 配置管理 | ⭐⭐ | 状态监控，配置管理 |

## 📚 文档

- **[交叉编译指南](CROSS_COMPILE.md)** - 完整的跨平台构建指南
- **[Linux 支持指南](LINUX_SUPPORT.md)** - 详细的 Linux 支持信息
- **[构建脚本说明](../scripts/README.md)** - 构建脚本使用指南

## 🐛 已知问题

### 当前限制

1. **ZLIB 支持** - 在 macOS 上暂时禁用（宏冲突问题）
2. **OpenMP 支持** - 在 macOS 上暂时禁用（编译器不支持）
3. **JPEG 支持** - 暂时禁用（依赖 ZLIB）

### 解决方案

- 使用捆绑依赖确保独立发布
- 提供详细的错误信息和解决建议
- 支持降级构建（禁用有问题的功能）

## 🔄 更新历史

### v1.0.0 (当前版本)
- ✅ 支持 Windows x64 交叉编译
- ✅ 支持 macOS ARM64/x64 构建
- ✅ 支持 Linux x64 原生构建
- ✅ 实现统一构建脚本
- ✅ 建立标准目录结构
- ✅ 完善 CI/CD 支持
- ✅ 创建详细文档

## 🆘 获取帮助

```bash
# 查看构建脚本帮助
./scripts/build-cross-platform.sh help

# 查看构建状态
./scripts/build-cross-platform.sh status

# 查看详细构建信息
./scripts/build-cross-platform.sh <platform> --verbose
```

## 📞 支持

如果您遇到问题或需要帮助，请：

1. 查看相关文档
2. 检查构建状态
3. 查看错误日志
4. 提交 Issue 或 Pull Request
