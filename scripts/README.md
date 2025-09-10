# RawSpeed 构建脚本

本目录包含用于构建 RawSpeed 库的脚本，支持跨平台编译和独立发布。

## 脚本概览

### 🚀 主要构建脚本

| 脚本 | 用途 | 推荐度 |
|------|------|--------|
| `build-unified.sh` | **统一跨平台构建脚本** | ⭐⭐⭐⭐⭐ |

## 详细说明

### `build-unified.sh` - 统一构建脚本（推荐）

**最简单的使用方式**，提供统一的接口来构建所有平台：

```bash
# 构建所有平台
./scripts/build-unified.sh all

# 构建特定平台
./scripts/build-unified.sh windows-x64
./scripts/build-unified.sh macos-arm64
./scripts/build-unified.sh macos-x64
./scripts/build-unified.sh linux-x64

# 清理构建
./scripts/build-unified.sh all --clean

# 选项
./scripts/build-unified.sh all --jobs 8 --verbose
./scripts/build-unified.sh windows-x64 --debug
```

**特点：**
- ✅ 统一的命令接口
- ✅ 支持所有平台
- ✅ 彩色输出和进度显示
- ✅ 错误处理和回退
- ✅ 与 LibRaw 构建脚本风格一致

## 使用示例

### 基本用法

```bash
# 查看帮助
./scripts/build-unified.sh --help

# 构建所有平台
./scripts/build-unified.sh all

# 构建特定平台
./scripts/build-unified.sh macos-arm64
./scripts/build-unified.sh windows-x64 --clean
./scripts/build-unified.sh linux-x64 --debug --verbose
```

### 高级选项

```bash
# 使用更多并行任务
./scripts/build-unified.sh all --jobs 8

# 详细输出
./scripts/build-unified.sh macos-arm64 --verbose

# 清理后构建
./scripts/build-unified.sh all --clean

# 调试构建
./scripts/build-unified.sh linux-x64 --debug
```

## 支持的平台

- **windows-x64**: Windows 64位 (MinGW-w64)
- **macos-arm64**: macOS Apple Silicon
- **macos-x64**: macOS Intel
- **linux-x64**: Linux 64位
- **all**: 所有支持的平台

## 构建选项

### 平台选择
- `windows-x64`: Windows 64位 (MinGW-w64)
- `macos-arm64`: macOS Apple Silicon
- `macos-x64`: macOS Intel
- `linux-x64`: Linux 64位
- `all`: 所有支持的平台

### 构建类型
- `--release`: 发布构建 (默认)
- `--debug`: 调试构建
- `--coverage`: 代码覆盖率构建
- `--sanitize`: 内存安全工具构建
- `--fuzz`: 模糊测试构建

### 其他选项
- `-c, --clean`: 清理构建目录
- `-j, --jobs N`: 并行编译任务数 (默认: 4)
- `-v, --verbose`: 详细输出
- `-h, --help`: 显示帮助信息

## 故障排除

### 常见问题

1. **CMake 版本过低**
   ```
   错误: CMake 3.22+ required
   解决: 升级 CMake 到 3.22 或更高版本
   ```

2. **编译器不支持 C++20**
   ```
   错误: C++20 standard not supported
   解决: 升级编译器到支持 C++20 的版本
   ```

3. **交叉编译工具链缺失**
   ```
   错误: x86_64-w64-mingw32-gcc not found
   解决: 安装 MinGW-w64 工具链
   ```

4. **内存不足**
   ```
   错误: 编译过程中内存不足
   解决: 减少并行任务数: -j 2
   ```

### 调试构建

```bash
# 详细输出
./scripts/build-unified.sh macos-arm64 --verbose

# 调试构建
./scripts/build-unified.sh linux-x64 --debug

# 清理后重新构建
./scripts/build-unified.sh windows-x64 --clean --verbose
```

## 贡献

如果您发现构建系统的问题或有改进建议，请：

1. 检查现有的 CMake 模块是否满足需求
2. 遵循现有的代码风格和命名约定
3. 确保新功能在所有支持的平台上工作
4. 更新相关文档