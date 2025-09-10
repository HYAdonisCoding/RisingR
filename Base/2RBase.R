# 2.1 测试中文输出
c("北京", "上海", "广州", "深圳")
c(1)
1
list(c("北京", "上海", "广州", "深圳"), c(1), "Hello World")

# 函数
function(x, y) {
    x^2 + y^3
}

# 环境
new.env()

# 依赖包
# install.packages("languageserver", repos="https://cran.r-project.org/")
library(languageserver)

# 查看当前本地化设置
Sys.getlocale()