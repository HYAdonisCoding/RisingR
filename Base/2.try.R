######牛刀小试：提取数据框子集，并对部分列做统计计算#########
mtcars.new <- mtcars[,c("mpg","disp","am")]
mtcars.new <- mtcars.new[mtcars.new$am == 0,]
mtcars.new
# mpg的均值
mean(mtcars.new$mpg)

# mpg的标准差
sd(mtcars.new$mpg)


# disp的均值
mean(mtcars.new$disp)

# 对比分析：自动挡 vs 手动挡
aggregate(mtcars[, c("mpg", "disp")], by = list(变速器 = mtcars$am), FUN = mean)
