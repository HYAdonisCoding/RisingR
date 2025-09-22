#####牛刀小试#####

# 定义行数序列，从2000开始，每次增加2000，共10个数据点，用于生成不同大小的数据集的行数
n_row<-seq(2000,2000*10,2000)

# 定义列数序列，从50开始，每次增加50，共10个数据点，用于生成不同大小的数据集的列数
n_col<-seq(50,50*10,50)

# 定义文件名前缀，生成10个数据集的文件名 "dataset1" 到 "dataset10"
# file<-paste0("dataset",1:10)
data_dir <- file.path(getwd(), "Data")
if (!dir.exists(data_dir)) dir.create(data_dir)
file <- file.path(data_dir, paste0("dataset", 1:10))

# 使用for循环，遍历1到10，依次生成不同大小的数据集并进行读写测试
for (i in 1:10){
  
  # 生成一个随机正态分布数据矩阵，行数为n_row[i]，列数为n_col[i]
  data<-matrix(c(rnorm(n_row[i]*n_col[i])),nrow = n_row[i])
  
  # 为数据矩阵的列命名，列名格式为 "col1", "col2", ..., "coln"
  colnames(data)<-paste0("col",1:n_col[i])
  
  # 计算数据矩阵占用内存大小，并格式化为以KB为单位的字符串，方便输出显示
  data_size<-format(object.size(data),units="Kb")
  
  # 使用system.time()测量写入CSV格式文本文件的时间
  time1<-system.time({
    write.table(x=data,                      # 要写入的数据
                file = paste0(file[i],".txt"), # 文件名，格式为 dataseti.txt
                append = FALSE,               # 不追加，覆盖写入
                row.names = FALSE,            # 不写入行名
                sep = ",",                   # 以逗号分隔
                fileEncoding = "GBK")        # 文件编码为GBK
  })
  
  # 使用system.time()测量从CSV格式文本文件读取数据的时间
  time2<-system.time({
    tmp1<-read.table(file = paste0(file[i],".txt"), # 读取文件 dataseti.txt
                     sep = ",",                     # 以逗号分隔
                     fileEncoding = "GBK")          # 文件编码为GBK
  })
  
  # 使用system.time()测量写入Excel文件的时间，数据先转为数据框格式
  time3<-system.time({
    openxlsx::write.xlsx(x = as.data.frame(data),   # 要写入的数据框
                         file = paste0(file[i],".xlsx"), # 文件名 dataseti.xlsx
                         asTable = TRUE)            # 以表格格式写入Excel
  })
  
  # 使用system.time()测量从Excel文件读取数据的时间，读取第一个工作表
  time4<-system.time({
    tmp2<-openxlsx::read.xlsx(xlsxFile = paste0(file[i],".xlsx"), sheet = 1 )
  })
  
  # 打印当前数据集名称、数据大小、行数和列数，方便观察数据规模
  cat("数据集：",file[i],";大小：",data_size,";",nrow(data),"行",ncol(data),"列","\n")
  
  # 打印写入文本文件和写入Excel文件所用时间，单位为秒
  cat("write.table用时：",time1[3],"秒; write.xlsx用时：",time3[3],"秒","\n")
  
  # 打印读取文本文件和读取Excel文件所用时间，单位为秒
  cat("read.table用时：",time2[3],"秒; read.xlsx用时：",time4[3],"秒","\n")
}