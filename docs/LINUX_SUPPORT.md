# Linux x64 支持指南

RawSpeed 的 `linux-x64` 构建支持多种 Linux 发行版，包括 Ubuntu 和 CentOS。

## ✅ 支持的 Linux 发行版

### 主要发行版
- **Ubuntu** 18.04+ (推荐 20.04+)
- **CentOS** 7+ (推荐 8+)
- **RHEL** 7+ (推荐 8+)
- **Debian** 10+
- **Fedora** 30+
- **openSUSE** 15+

### 其他兼容发行版
- **AlmaLinux** 8+
- **Rocky Linux** 8+
- **Amazon Linux** 2+
- **SUSE Linux Enterprise** 15+

## 🔧 系统要求

### 最低要求
- **CPU**: x86_64 架构
- **内存**: 2GB RAM (构建时)
- **磁盘空间**: 200MB 可用空间
- **GCC**: 7.0+ 或 Clang 6.0+
- **CMake**: 3.16+

### 推荐配置
- **CPU**: x86_64 架构，4+ 核心
- **内存**: 4GB+ RAM
- **磁盘空间**: 500MB+ 可用空间
- **GCC**: 9.0+ 或 Clang 10.0+
- **CMake**: 3.20+

## 📦 依赖安装

### Ubuntu/Debian 系统

```bash
# 更新包管理器
sudo apt update

# 安装基础构建工具
sudo apt install -y build-essential cmake git

# 安装可选依赖（用于完整功能）
sudo apt install -y libxml2-dev libjpeg-dev zlib1g-dev libomp-dev

# 验证安装
gcc --version
cmake --version
```

### CentOS/RHEL 系统

```bash
# 安装 EPEL 仓库（CentOS 7）
sudo yum install -y epel-release

# 或者使用 dnf（CentOS 8+/RHEL 8+）
sudo dnf install -y epel-release

# 安装基础构建工具
sudo yum install -y gcc gcc-c++ make cmake git
# 或者
sudo dnf install -y gcc gcc-c++ make cmake git

# 安装可选依赖
sudo yum install -y libxml2-devel libjpeg-devel zlib-devel
# 或者
sudo dnf install -y libxml2-devel libjpeg-devel zlib-devel

# 验证安装
gcc --version
cmake --version
```

### Fedora 系统

```bash
# 安装基础构建工具
sudo dnf install -y gcc gcc-c++ make cmake git

# 安装可选依赖
sudo dnf install -y libxml2-devel libjpeg-devel zlib-devel

# 验证安装
gcc --version
cmake --version
```

## 🚀 构建方法

### 1. 使用统一构建脚本（推荐）

```bash
# 构建 Linux x64
./scripts/build-cross-platform.sh linux

# 使用更多并行任务
./scripts/build-cross-platform.sh linux --jobs 8

# 详细输出
./scripts/build-cross-platform.sh linux --verbose

# 调试构建
./scripts/build-cross-platform.sh linux --debug
```

### 2. 使用单个平台脚本

```bash
# 构建 Linux x64
./scripts/build.sh linux-x64

# 清理并重新构建
./scripts/build.sh linux-x64 --clean

# 使用更多并行任务
./scripts/build.sh linux-x64 --jobs 8
```

### 3. 手动 CMake 构建

```bash
# 创建构建目录
mkdir -p build/linux-x64
cd build/linux-x64

# 配置 CMake
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DBINARY_PACKAGE_BUILD=ON \
  -DWITH_OPENMP=OFF \
  -DWITH_PUGIXML=ON \
  -DUSE_BUNDLED_PUGIXML=ON \
  -DALLOW_DOWNLOADING_PUGIXML=ON \
  -DWITH_ZLIB=OFF \
  -DWITH_JPEG=OFF \
  -DBUILD_TESTING=OFF \
  -DBUILD_BENCHMARKING=OFF \
  -DBUILD_DOCS=OFF \
  -DBUILD_FUZZERS=OFF \
  -DBUILD_TOOLS=OFF \
  -DRAWSPEED_ENABLE_WERROR=OFF \
  -DRAWSPEED_ENABLE_CLANG_TIDY_WERROR=OFF \
  ../..

# 编译
make -j$(nproc)
```

## 📁 构建产物

构建完成后，产物位于 `build/linux-x64/` 目录：

```
build/linux-x64/
├── lib/
│   ├── librawspeed.a                    # 主库文件
│   ├── librawspeed_get_number_of_processor_cores.a
│   └── libpugixml.a                     # 依赖库
└── bin/                                 # 可执行文件（如果有）
```

## 🔍 验证构建

### 检查库文件

```bash
# 查看库文件信息
file build/linux-x64/lib/librawspeed.a
ldd build/linux-x64/lib/librawspeed.a 2>/dev/null || echo "静态库，无动态依赖"

# 查看库文件大小
ls -lh build/linux-x64/lib/
```

### 测试库文件

```bash
# 创建简单的测试程序
cat > test_rawspeed.cpp << 'EOF'
#include <iostream>
#include "rawspeed/RawSpeed-API.h"

int main() {
    std::cout << "RawSpeed library loaded successfully!" << std::endl;
    return 0;
}
EOF

# 编译测试程序
g++ -I. -Lbuild/linux-x64/lib test_rawspeed.cpp -lrawspeed -lpugixml -o test_rawspeed

# 运行测试
./test_rawspeed
```

## 🐳 Docker 支持

### 使用 Docker 构建

```bash
# 创建 Dockerfile
cat > Dockerfile.linux << 'EOF'
FROM ubuntu:20.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建
RUN ./scripts/build-cross-platform.sh linux

# 设置入口点
ENTRYPOINT ["/bin/bash"]
EOF

# 构建 Docker 镜像
docker build -f Dockerfile.linux -t rawspeed-linux .

# 运行容器
docker run -it rawspeed-linux
```

## 🔧 故障排除

### 常见问题

#### 1. GCC 版本过低
```bash
# 错误信息
error: #error "GCC version must be at least 7.0"

# 解决方案
# Ubuntu 18.04+
sudo apt install -y gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 90
```

#### 2. CMake 版本过低
```bash
# 错误信息
CMake Error: CMake 3.16 or higher is required

# 解决方案
# 下载最新 CMake
wget https://github.com/Kitware/CMake/releases/download/v3.28.1/cmake-3.28.1-linux-x86_64.tar.gz
tar -xzf cmake-3.28.1-linux-x86_64.tar.gz
sudo mv cmake-3.28.1-linux-x86_64 /opt/cmake
export PATH=/opt/cmake/bin:$PATH
```

#### 3. 内存不足
```bash
# 错误信息
g++: fatal error: Killed signal terminated program cc1plus

# 解决方案
# 减少并行任务数
./scripts/build-cross-platform.sh linux --jobs 2

# 或者增加交换空间
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

#### 4. 网络问题
```bash
# 错误信息
CMake Error: Failed to download pugixml

# 解决方案
# 设置代理（如果需要）
export http_proxy=http://proxy:port
export https_proxy=http://proxy:port

# 或者手动下载依赖
mkdir -p src/external/pugixml
cd src/external/pugixml
wget https://github.com/zeux/pugixml/releases/download/v1.9/pugixml-1.9.tar.gz
tar -xzf pugixml-1.9.tar.gz
```

## 📊 性能优化

### 编译优化

```bash
# 使用更多并行任务
./scripts/build-cross-platform.sh linux --jobs $(nproc)

# 使用 Clang 编译器（通常更快）
export CC=clang
export CXX=clang++
./scripts/build-cross-platform.sh linux
```

### 系统优化

```bash
# 增加文件描述符限制
ulimit -n 65536

# 使用 tmpfs 加速编译
sudo mount -t tmpfs -o size=2G tmpfs /tmp
```

## 📝 注意事项

1. **静态链接**: 构建的库是静态链接的，不依赖系统库
2. **架构兼容**: 构建的库只能在 x86_64 架构的 Linux 系统上运行
3. **依赖管理**: 使用捆绑依赖，确保独立发布
4. **调试信息**: 默认不包含调试信息，如需调试请使用 `--debug` 选项

## 🆘 获取帮助

```bash
# 查看构建脚本帮助
./scripts/build-cross-platform.sh help
./scripts/build.sh --help

# 查看构建状态
./scripts/build-cross-platform.sh status

# 查看详细构建信息
./scripts/build-cross-platform.sh linux --verbose
```
