# RawSpeed 构建脚本

本目录包含用于构建 RawSpeed 库的各种脚本，支持跨平台编译和独立发布。

## 脚本概览

### 🚀 主要构建脚本

| 脚本 | 用途 | 推荐度 |
|------|------|--------|
| `build-cross-platform.sh` | **统一跨平台构建脚本** | ⭐⭐⭐⭐⭐ |
| `build.sh` | 单个平台构建脚本 | ⭐⭐⭐⭐ |
| `build-release.sh` | 发布构建脚本 | ⭐⭐⭐ |
| `build-config.sh` | 构建配置管理 | ⭐⭐ |

### 📋 详细说明

#### 1. `build-cross-platform.sh` - 统一构建脚本（推荐）

**最简单的使用方式**，提供统一的接口来构建所有平台：

```bash
# 构建所有平台
./scripts/build-cross-platform.sh all

# 构建特定平台
./scripts/build-cross-platform.sh windows
./scripts/build-cross-platform.sh macos
./scripts/build-cross-platform.sh macos-arm64
./scripts/build-cross-platform.sh macos-x64
./scripts/build-cross-platform.sh linux

# 清理和状态
./scripts/build-cross-platform.sh clean
./scripts/build-cross-platform.sh status

# 选项
./scripts/build-cross-platform.sh all --jobs 8 --verbose
./scripts/build-cross-platform.sh windows --debug
```

**特点：**
- ✅ 统一的命令接口
- ✅ 支持所有平台
- ✅ 内置状态检查
- ✅ 彩色输出和进度显示
- ✅ 错误处理和回退

#### 2. `build.sh` - 单个平台构建脚本

**精确控制**单个平台的构建过程：

```bash
# 构建特定平台
./scripts/build.sh windows-x64
./scripts/build.sh macos-arm64
./scripts/build.sh macos-x64
./scripts/build.sh linux-x64

# 选项
./scripts/build.sh windows-x64 --clean --jobs 8 --verbose
./scripts/build.sh macos-arm64 --debug
```

**特点：**
- ✅ 精确的平台控制
- ✅ 详细的构建信息
- ✅ 支持清理和调试选项
- ✅ 自动依赖检查

#### 3. `build-release.sh` - 发布构建脚本

**批量构建**多个平台并创建发布包：

```bash
# 构建所有平台
./scripts/build-release.sh --all

# 构建特定平台
./scripts/build-release.sh --platforms windows-x64,macos-arm64

# 创建发布包
./scripts/build-release.sh --all --package

# 清理和重新构建
./scripts/build-release.sh --clean --all
```

**特点：**
- ✅ 批量构建多个平台
- ✅ 自动创建发布包
- ✅ 支持并行构建
- ✅ 发布目录管理

#### 4. `build-config.sh` - 构建配置管理

**管理**不同的构建配置和状态：

```bash
# 查看构建状态
./scripts/build-config.sh status

# 查看特定平台信息
./scripts/build-config.sh info macos-arm64

# 清理构建目录
./scripts/build-config.sh clean

# 列出所有构建目录
./scripts/build-config.sh list
```

**特点：**
- ✅ 构建状态监控
- ✅ 配置管理
- ✅ 目录清理
- ✅ 信息查询

## 🎯 使用建议

### 新手用户
```bash
# 推荐：使用统一构建脚本
./scripts/build-cross-platform.sh all
```

### 开发者
```bash
# 开发时使用单个平台脚本
./scripts/build.sh macos-arm64 --debug --verbose
```

### 发布管理
```bash
# 发布时使用发布构建脚本
./scripts/build-release.sh --all --package
```

## 📁 构建目录结构

所有构建产物都放在 `build/` 目录下：

```
build/
├── windows-x64/     # Windows x64 构建
├── macos-arm64/     # macOS ARM64 构建
├── macos-x64/       # macOS x64 构建
└── linux-x64/       # Linux x64 构建
```

## 🔧 支持的平台

- **Windows x64** (x86_64-w64-mingw32) - 交叉编译
- **macOS ARM64** (aarch64-apple-darwin) - 交叉编译
- **macOS x64** (x86_64-apple-darwin) - 原生编译
- **Linux x64** (native) - 支持 Ubuntu、CentOS、RHEL、Debian、Fedora 等

> 📖 **详细 Linux 支持信息**: 请参考 [Linux 支持指南](../docs/LINUX_SUPPORT.md)

## 📝 注意事项

1. **依赖要求**：确保已安装相应的交叉编译工具链
2. **权限**：脚本需要执行权限 (`chmod +x`)
3. **网络**：首次构建需要下载依赖包
4. **空间**：每个平台构建大约需要 100-200MB 空间

## 🆘 故障排除

### 常见问题

1. **权限错误**：`chmod +x scripts/*.sh`
2. **工具链缺失**：检查 MinGW-w64 或 Xcode 安装
3. **网络问题**：确保能访问 GitHub 下载依赖
4. **空间不足**：清理旧的构建目录

### 获取帮助

```bash
# 查看脚本帮助
./scripts/build-cross-platform.sh help
./scripts/build.sh --help
./scripts/build-release.sh --help
./scripts/build-config.sh help
```
