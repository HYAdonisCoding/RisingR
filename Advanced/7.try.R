##### 牛刀小试：尝试实现层次聚类（详细注释版） #####
# 任务：使用 flexclust 扩展包的 nutrient 数据集，根据营养成分对各种肉类进行层次聚类。
# 说明：本脚本在每一步都加入了注释，兼顾交互式（RStudio/console）和非交互式（Rscript）运行场景；
#      在非交互式场景下会把树状图保存为 PNG 文件，便于查看（避免“图形闪一下就没了”）。

# ---------------------------
# 1) 包依赖检查（如无则安装），加载包
# ---------------------------
if (!requireNamespace("flexclust", quietly = TRUE)) {
  install.packages("flexclust", dependencies = TRUE)
}
if (!requireNamespace("NbClust", quietly = TRUE)) {
  install.packages("NbClust", dependencies = TRUE)
}
# 上面两行保证在 Rscript 非交互环境下也能自动安装所需包（前提是用户有网络和写入权限）。

library(flexclust)   # 包含 nutrient 数据集
library(NbClust)     # 用于通过多指标评估推荐聚类数目

# ---------------------------
# 2) 读取数据并简单检查
# ---------------------------
data(nutrient)       # 从 flexclust 包加载示例数据集
# nutrient 是一个矩阵或数据框，每行是一个样本（肉类），每列是一个营养指标
# 推荐先查看前几行以确认数据结构
if (interactive()) {
  message("数据预览（前 6 行）：")
  print(head(nutrient))
} else {
  # 在非交互式环境中，仍然输出少量信息到控制台日志
  message("数据维度: ", paste(dim(nutrient), collapse = " x "))
}

# ---------------------------
# 3) 数据预处理：中心化与标准化
# ---------------------------
# scale(..., center = TRUE, scale = TRUE) 会对每列变量减去均值并除以标准差，
# 使得不同量纲的营养指标具有可比性（常用于计算欧氏距离的场景）。
nutrient_scaled <- scale(nutrient, center = TRUE, scale = TRUE)

# ---------------------------
# 4) 决定聚类数目（可选）：使用 NbClust（多个指标投票）
# ---------------------------
# NbClust 会运行多种指标（如 CH、Silhouette 等）并给出推荐的聚类数目（最常见的投票结果）。
# 运行时会产生较多输出；如果你只想自动选择 k，可以把结果保存在 nb 里然后查看 nb$Best.nc。
nb <- tryCatch({
  NbClust(data = nutrient_scaled,
          distance = "euclidean",
          min.nc = 2,
          max.nc = 8,
          method = "average",
          index = "all")   # 使用所有默认指标进行投票
}, error = function(e) {
  warning("NbClust 运行失败：", conditionMessage(e))
  NULL
})

if (!is.null(nb)) {
  # NbClust 的 Best.nc 字段通常包含每个指标推荐的聚类数，下面显示“投票结果”
  if (!is.null(nb$All.index)) {
    message("NbClust 完成：查看 nb$Best.nc 或 nb$All.index 获取详细结果。")
  } else if (!is.null(nb$Best.nc)) {
    message("NbClust 投票结果（部分展示）：")
    print(head(nb$Best.nc))
  }
} else {
  message("跳过 NbClust 推荐步骤（可能因网络或包版本问题）。")
}

# ---------------------------
# 5) 计算距离矩阵（这里使用欧氏距离）
# ---------------------------
# dist 返回样本间的距离（下三角压缩形式），适用于 hclust。
nutrient_dist <- dist(nutrient_scaled, method = "euclidean")

# ---------------------------
# 6) 层次聚类（average linkage / UPGMA）
# ---------------------------
# method = "average" 表示使用平均连锁（UPGMA），可替换为 "complete"（完全连锁）或 "single"（单连接）。
fit_average <- hclust(nutrient_dist, method = "average")

# ---------------------------
# 7) 可视化：在交互式窗口绘图；在非交互式（Rscript）中保存 PNG
# ---------------------------
plot_title <- "平均距离层次聚类（average linkage）"

if (interactive()) {
  # 交互式会话（如 RStudio）直接显示图形窗口
  plot(fit_average, hang = -1, cex = 0.9, main = plot_title)
  # 用 rect.hclust 在树上标出 k 个簇（默认示例 k = 3）
  k <- 3
  rect.hclust(fit_average, k = k, border = 2:(k+1))
} else {
  # 非交互式：把图写入文件，避免脚本运行结束图形窗口消失
  out_file <- "dendrogram_average.png"
  png(filename = out_file, width = 1200, height = 800, res = 150)
  plot(fit_average, hang = -1, cex = 0.9, main = plot_title)
  k <- 3
  rect.hclust(fit_average, k = k, border = 2:(k+1))
  dev.off()
  message("已将树状图保存为: ", out_file)
}

# ---------------------------
# 8) 导出聚类结果（分配样本到簇）
# ---------------------------
# 使用 cutree 把树切成 k 个簇，并输出各簇的大小和每个样本所属簇
k <- 3  # 如果你根据 NbClust 或业务需求决定了其他 k，请修改此处
clusters <- cutree(fit_average, k = k)

# 输出每簇样本数
message("各簇样本计数：")
print(table(clusters))

# 把聚类标签并回原始数据（方便后续分析）
nutrient_clustered <- as.data.frame(nutrient)
nutrient_clustered$cluster <- clusters

# 计算每簇的均值（用于描述性解释）
cluster_centers <- aggregate(. ~ cluster, data = nutrient_clustered, FUN = mean)
message("各簇中心（变量均值）：")
print(cluster_centers)

# ---------------------------
# 9) 结果解读提示（注释）
# ---------------------------
# - 若不同簇的中心在某些营养指标上差异明显，可据此给簇贴标签（例如：高脂/低脂类）。
# - 聚类不是“因果”，只是根据相似性把样本分组；分组的有效性需结合领域知识和外部标签验证。
# - 若希望用其它距离或聚类方法：尝试 method = "complete" 或 "ward.D2"（用于最小化群内方差）。
# - 若数据中存在缺失值，请在 scale() 前先处理（如 impute 或删除含缺失的样本）。
#
# 运行建议：
# - 交互调试：在 RStudio 中逐行运行并观察 plot、table 输出。
# - 批量运行：通过 Rscript 执行脚本，会在当前目录生成 dendrogram_average.png。
#
# 结束
