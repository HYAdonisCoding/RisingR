# 设置 R 编码为 UTF-8，确保中文输出正常
# Sys.setlocale("LC_CTYPE", "zh_CN.UTF-8")
# options(encoding = "UTF-8")
main <- function(x) {
    cities <- c("北京", "上海", "广州", "深圳")
    result <- paste0(cities, x)   # 直接字符串拼接
    return(result)
}

# install.packages("devtools", repos = "https://cloud.r-project.org", dependencies = TRUE)
# install.packages("shiny", repos = "https://cloud.r-project.org")
# library(devtools)

create_my_package <- function(pkg_path) {
    if (!dir.exists(pkg_path)) {
        dir.create(pkg_path, recursive = TRUE)
    }
    dir.create(file.path(pkg_path, "R"), showWarnings = FALSE)
    desc_file <- file.path(pkg_path, "DESCRIPTION")
    if (!file.exists(desc_file)) {
        writeLines(c(
            "Package: myPackage",
            "Type: Package",
            "Title: My Custom R Package",
            "Version: 0.1.0",
            "Author: Eason",
            "Maintainer: Eason <eason@example.com>",
            "Description: Auto-generated package",
            "License: MIT",
            "Encoding: UTF-8",
            "LazyData: true"
        ), desc_file)
    }
    namespace_file <- file.path(pkg_path, "NAMESPACE")
    if (!file.exists(namespace_file)) {
        writeLines("exportPattern('^[[:alpha:]]+')", namespace_file)
    }
    message("R 包已在临时目录创建: ", pkg_path)
}


# 如果不是在交互环境下运行（即通过 Rscript）
if (!interactive()) {
  main('市')
  # 调用函数，指定包路径
  # create_my_package("/Users/adam/Documents/Developer/myPackage")
}
