# RisingR

RisingR 是一个用于学习 R 语言从入门到精通的个人项目。该项目提供中文输出示例、函数练习、环境操作示例以及基础包加载示例，旨在帮助学习者在 macOS 上使用 VS Code 和 R 环境进行高效学习。

## 项目结构

```
RisingR/
├── Base/
│   └── 2RBase.R        # 基础练习脚本，包含中文输出测试、函数示例、环境操作和包加载
├── README.md           # 项目说明文件
```

## 环境配置

1. 安装 R（建议 R 4.5 及以上）
2. 安装 VS Code，并安装 R 插件（`R Extension` by Yuki Ueda）
3. 在用户目录下创建 `.Rprofile` 配置文件：
```r
Sys.setlocale("LC_CTYPE", "zh_CN.UTF-8")
options(encoding = "UTF-8")
```
4. 确保 VS Code 终端使用 UTF-8：
```json
"terminal.integrated.env.osx": {
    "LANG": "zh_CN.UTF-8"
}
```

## 使用说明

- 打开 VS Code 并打开项目目录 `RisingR/`
- 打开 `2RBase.R`，可以直接运行脚本
- 脚本中包含：
  - 中文输出测试
  - 简单函数示例
  - 新建环境示例
  - 基础包加载（languageserver）

## 注意事项

- 确保 R 脚本文件保存为 UTF-8 编码
- 若使用 `Rscript` 在终端运行，建议加参数：
```bash
Rscript --encoding=UTF-8 2RBase.R
```

## 目标

- 提供一个完整的学习 R 语言环境配置示例
- 帮助学习者熟悉 R 基础语法、函数、环境和包管理
- 保证中文输出在 macOS + VS Code 下正常显示

## 许可证

本项目采用 [MIT 许可证](LICENSE)。