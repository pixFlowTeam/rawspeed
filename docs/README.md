# RawSpeed 文档

欢迎来到 RawSpeed 项目文档！这里包含了所有关于构建、使用和开发 RawSpeed 的详细信息。

## 📚 文档索引

### 🚀 快速开始

- **[交叉编译指南](../CROSS_COMPILE.md)** - 完整的跨平台构建指南
  - 支持的平台和架构
  - 快速开始指南
  - 依赖安装说明
  - 手动构建步骤

### 🔧 平台特定文档

- **[Linux 支持指南](LINUX_SUPPORT.md)** - 详细的 Linux 支持信息
  - 支持的 Linux 发行版
  - 系统要求和依赖安装
  - 构建方法和故障排除
  - Docker 支持

### 📊 项目状态

- **[构建状态](BUILD_STATUS.md)** - 当前构建支持状态
  - 平台支持概览
  - 构建特性说明
  - 已知问题和限制
  - 更新历史

### 🛠️ 开发工具

- **[构建脚本说明](../scripts/README.md)** - 构建脚本使用指南
  - 脚本概览和用途
  - 使用方法和示例
  - 故障排除

## 🎯 快速导航

### 我是新用户
1. 阅读 [交叉编译指南](../CROSS_COMPILE.md) 了解基本概念
2. 查看 [构建状态](BUILD_STATUS.md) 了解支持的平台
3. 根据您的平台查看相应的详细文档

### 我要构建 RawSpeed
1. 查看 [快速开始](../CROSS_COMPILE.md#快速开始) 部分
2. 根据您的平台安装依赖
3. 使用统一构建脚本：`./scripts/build-cross-platform.sh all`

### 我使用 Linux
1. 查看 [Linux 支持指南](LINUX_SUPPORT.md)
2. 安装必要的依赖
3. 运行：`./scripts/build-cross-platform.sh linux`

### 我遇到问题
1. 查看 [故障排除](../CROSS_COMPILE.md#故障排除) 部分
2. 检查 [已知问题](BUILD_STATUS.md#已知问题)
3. 查看平台特定的故障排除指南

## 📋 支持的平台

| 平台 | 架构 | 状态 | 文档 |
|------|------|------|------|
| Windows | x64 | ✅ 支持 | [交叉编译指南](../CROSS_COMPILE.md) |
| macOS | ARM64 | ✅ 支持 | [交叉编译指南](../CROSS_COMPILE.md) |
| macOS | x64 | ✅ 支持 | [交叉编译指南](../CROSS_COMPILE.md) |
| Linux | x64 | ✅ 支持 | [Linux 支持指南](LINUX_SUPPORT.md) |

## 🔧 构建脚本

| 脚本 | 用途 | 文档 |
|------|------|------|
| `build-cross-platform.sh` | 统一构建脚本 | [构建脚本说明](../scripts/README.md) |
| `build.sh` | 单个平台构建 | [构建脚本说明](../scripts/README.md) |
| `build-release.sh` | 发布构建 | [构建脚本说明](../scripts/README.md) |
| `build-config.sh` | 配置管理 | [构建脚本说明](../scripts/README.md) |

## 📞 获取帮助

如果您需要帮助，请：

1. **查看文档** - 首先查看相关文档
2. **检查状态** - 运行 `./scripts/build-cross-platform.sh status`
3. **查看帮助** - 运行 `./scripts/build-cross-platform.sh help`
4. **提交问题** - 在 GitHub 上提交 Issue

## 🔄 文档更新

本文档会随着项目的发展持续更新。如果您发现文档有误或需要补充，欢迎提交 Pull Request！

---

**最后更新**: 2024年9月
**版本**: v1.0.0
