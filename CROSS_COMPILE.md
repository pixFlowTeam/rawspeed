# RawSpeed 交叉编译指南

本文档介绍如何为不同平台交叉编译 RawSpeed 库，并创建独立发布包。

## 支持的平台

- **Windows x64** (x86_64-w64-mingw32)
- **macOS ARM64** (aarch64-apple-darwin)
- **macOS x64** (x86_64-apple-darwin)
- **Linux x64** (native) - 支持 Ubuntu、CentOS、RHEL、Debian、Fedora 等

> 📖 **详细 Linux 支持信息**: 请参考 [Linux 支持指南](docs/LINUX_SUPPORT.md)

## 快速开始

### 1. 使用统一构建脚本（推荐）

```bash
# 构建所有平台
./scripts/build-cross-platform.sh all

# 构建特定平台
./scripts/build-cross-platform.sh windows
./scripts/build-cross-platform.sh macos
./scripts/build-cross-platform.sh macos-arm64
./scripts/build-cross-platform.sh macos-x64
./scripts/build-cross-platform.sh linux

# 清理构建目录
./scripts/build-cross-platform.sh clean

# 查看构建状态
./scripts/build-cross-platform.sh status

# 使用更多并行任务
./scripts/build-cross-platform.sh all --jobs 8

# 详细输出
./scripts/build-cross-platform.sh windows --verbose

# 调试构建
./scripts/build-cross-platform.sh macos --debug
```

### 2. 使用发布构建脚本

```bash
# 编译所有平台
./scripts/build-release.sh --all

# 编译特定平台
./scripts/build-release.sh --platforms windows-x64,macos-arm64

# 清理并重新编译
./scripts/build-release.sh --clean --all

# 使用更多并行任务
./scripts/build-release.sh --all --jobs 8
```

### 3. 使用单个平台脚本

```bash
# 编译 Windows x64
./scripts/cross-compile.sh windows-x64

# 编译 macOS ARM64
./scripts/cross-compile.sh macos-arm64
```

### 4. 手动 CMake 配置

```bash
# Windows x64
mkdir -p build/windows-x64 && cd build/windows-x64
cmake \
  -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchains/x86_64-w64-mingw32.cmake \
  -C ../../cmake/standalone-release.cmake \
  ../..
make -j4

# macOS ARM64
mkdir -p build/macos-arm64 && cd build/macos-arm64
cmake \
  -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchains/aarch64-apple-darwin.cmake \
  -C ../../cmake/standalone-release.cmake \
  ../..
make -j4

# macOS x64
mkdir -p build/macos-x64 && cd build/macos-x64
cmake \
  -DCMAKE_OSX_ARCHITECTURES=x86_64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=13.5 \
  -C ../../cmake/standalone-release.cmake \
  ../..
make -j4

# Linux x64
mkdir -p build/linux-x64 && cd build/linux-x64
cmake \
  -C ../../cmake/standalone-release.cmake \
  ../..
make -j4
```

## 依赖要求

### Windows 交叉编译

在 macOS 上：
```bash
brew install mingw-w64
```

在 Ubuntu 上：
```bash
sudo apt-get install gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64
```

### macOS 交叉编译

需要安装 Xcode Command Line Tools：
```bash
xcode-select --install
```

### Linux 原生编译

**Ubuntu/Debian:**
```bash
sudo apt-get install build-essential cmake git
```

**CentOS/RHEL:**
```bash
sudo yum install gcc gcc-c++ make cmake git
# 或者 (CentOS 8+/RHEL 8+)
sudo dnf install gcc gcc-c++ make cmake git
```

**Fedora:**
```bash
sudo dnf install gcc gcc-c++ make cmake git
```

> 📖 **详细 Linux 支持信息**: 请参考 [Linux 支持指南](docs/LINUX_SUPPORT.md)

## 独立发布特性

### 内置依赖

所有依赖项都静态链接，无需额外安装：

- **OpenMP** (LLVM OpenMP) - 并行计算支持
- **Pugixml** - XML 解析
- **ZLIB** - 数据压缩

### 禁用功能

为了减少依赖和简化交叉编译，以下功能被禁用：

- JPEG 支持
- 测试套件
- 基准测试
- 文档生成
- 模糊测试
- 工具程序

### 输出结构

```
release/
├── README.md
├── windows-x64/
│   ├── include/           # 头文件
│   ├── librawspeed.a     # 主库文件
│   ├── libomp.a          # OpenMP 库
│   ├── libpugixml.a      # XML 库
│   └── libzlib.a         # 压缩库
├── macos-arm64/
│   └── ...
└── linux-x64/
    └── ...
```

## Docker 交叉编译

使用 Docker 进行隔离的交叉编译：

```bash
# 构建 Docker 镜像
docker build -f Dockerfile.cross-compile -t rawspeed-cross-compile .

# 运行交叉编译
docker run --rm -v $(pwd):/workspace rawspeed-cross-compile
```

## GitHub Actions

项目包含 GitHub Actions 工作流，自动为所有支持的平台进行交叉编译：

- 推送到 `main` 或 `develop` 分支时自动触发
- 支持手动触发
- 自动上传构建产物

## 构建目录结构

项目使用标准的构建目录命名规范，所有构建产物都放在 `build/` 目录下：

```
build/
├── windows-x64/     # Windows x64 构建 (x86_64-w64-mingw32)
├── macos-arm64/     # macOS ARM64 构建 (aarch64-apple-darwin)
├── macos-x64/       # macOS x64 构建 (x86_64-apple-darwin)
└── linux-x64/       # Linux x64 构建 (native)
```

### 构建产物

每个平台目录包含：

```
build/<platform>/
├── lib/
│   ├── librawspeed.a                    # 主库文件
│   ├── librawspeed_get_number_of_processor_cores.a
│   └── libpugixml.a                     # 依赖库
├── bin/                                 # 可执行文件（如果有）
└── src/                                 # 源代码和中间文件
```

## 故障排除

### 常见问题

1. **MinGW-w64 未找到**
   ```bash
   # macOS
   brew install mingw-w64
   
   # Ubuntu
   sudo apt-get install gcc-mingw-w64-x86-64
   ```

2. **Xcode 工具未安装**
   ```bash
   xcode-select --install
   ```

3. **权限问题**
   ```bash
   chmod +x scripts/*.sh
   ```

4. **Linux 构建问题**
   ```bash
   # 检查 GCC 版本
   gcc --version
   
   # 安装必要依赖
   sudo apt-get install build-essential cmake git
   ```

4. **内存不足**
   ```bash
   # 减少并行任务数
   ./scripts/build-release.sh --all --jobs 2
   ```

### 调试模式

启用详细输出：
```bash
./scripts/build-release.sh --all --verbose
```

### 清理构建

清理所有构建目录：
```bash
./scripts/build-release.sh --clean --all
```

## 高级配置

### 自定义工具链

可以修改 `cmake/toolchains/` 目录下的工具链文件来自定义编译选项。

### 添加新平台

1. 在 `cmake/toolchains/` 中创建新的工具链文件
2. 在构建脚本中添加新平台支持
3. 更新 GitHub Actions 工作流

### 静态链接选项

所有平台都配置为静态链接，确保独立发布：

- Windows: `-static-libgcc -static-libstdc++`
- macOS: `-static-libgcc -static-libstdc++`
- Linux: `-static-libgcc -static-libstdc++`

## 许可证

请确保遵守所有依赖库的许可证要求：

- RawSpeed: GPL-2.0
- OpenMP: Apache-2.0
- Pugixml: MIT
- ZLIB: Zlib

## 贡献

欢迎提交 Issue 和 Pull Request 来改进交叉编译支持。
