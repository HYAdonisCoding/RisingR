######牛刀小试:使用网格系统组合图形#########
# 如何在网格系统中组合图形时增加图形之间的距离

# 创建第一个图形p1：使用iris数据集，绘制Sepal.Length的密度直方图
p1 <- ggplot(iris,aes(x = Sepal.Length,y = ..density..)) + 
  geom_histogram(col = "black",fill = "white") +  # 绘制带黑色边框的白色填充直方图
  xlab(label  = NULL ) +  # 去除x轴标签
  ylab(label  = NULL )    # 去除y轴标签

# 创建第二个图形p2：使用iris数据集，绘制Species与Sepal.Length的箱线图
p2 <- ggplot(iris,aes(x = Species,y = Sepal.Length)) + 
  geom_boxplot() +  # 绘制箱线图
  xlab(label  = NULL ) +  # 去除x轴标签
  ylab(label  = NULL )    # 去除y轴标签

# 创建第三个图形p3：使用iris数据集，绘制Sepal.Length的密度曲线
p3 <- ggplot(iris,aes(x = Sepal.Length,y = ..density..)) + 
  geom_density() +  # 绘制密度曲线
  xlim(3,9) +       # 限制x轴范围在3到9之间
  xlab(label  = NULL ) +  # 去除x轴标签
  ylab(label  = NULL )    # 去除y轴标签

# 创建第四个图形p4：使用iris数据集，绘制Sepal.Length与Sepal.Width的散点图
p4 <- ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width)) + 
  geom_point()  # 绘制散点图

# 新建一个绘图页面，为后续绘图做好准备
grid.newpage()

# 创建一个viewport，定义一个3行3列的网格布局
# widths和heights参数分别定义列宽和行高的相对比例
# 这里第一列和第三列宽度为3，中间列宽度为1，行高同理
vp <-  viewport(layout = grid.layout(3,3,
                                     widths = c(3,1,3),
                                     heights = c(3,1,3)))

# 将定义好的viewport压入绘图堆栈，后续绘图将在该viewport中进行
pushViewport(vp)

# 将p1绘制在网格的第一行第一列位置
print(p1,vp = viewport(layout.pos.col = 1,layout.pos.row = 1))

# 将p2绘制在网格的第三行第一列位置
print(p2,vp = viewport(layout.pos.col = 1,layout.pos.row = 3))

# 将p3绘制在网格的第一行第三列位置
print(p3,vp = viewport(layout.pos.col = 3,layout.pos.row = 1))

# 将p4绘制在网格的第三行第三列位置
print(p4,vp = viewport(layout.pos.col = 3,layout.pos.row = 3))
