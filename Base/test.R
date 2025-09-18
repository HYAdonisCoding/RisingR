setwd("/Users/adam/Documents/Developer/MyGithub/RisingR/Base/myPackage")  # 进入包根目录
library(devtools)
# devtools::document()  # 生成 NAMESPACE 和帮助文档
# message("文档生成完成")


# 加载当前目录下的开发包，不需要安装
devtools::load_all(".")

# 调用你在 R/ 下写的函数，比如 stat()
stat(iris[, -5])