# library(DBI)
# if (!require("RMariaDB")){
#   install.packages("RMariaDB", repos = "https://cloud.r-project.org")
# }
# if (!require("readr")){
#   install.packages("readr", repos = "https://cloud.r-project.org")
# }
# library(RMariaDB)
# library(readr)

# # 1. 读取 CSV
# file_path <- "/Users/adam/Documents/Developer/MyGithub/RisingR/Data/airquality.txt"
# airquality <- read_csv(file_path, col_types = cols(), na = c("NA", ""))

# # 2. 连接数据库
# con <- dbConnect(
#   RMariaDB::MariaDB(),
#   user = "eason",
#   password = "chy123",
#   dbname = "example",
#   host = "127.0.0.1",
#   port = 3306
# )

# # 3. 写入 MySQL，如果表不存在就创建
# dbWriteTable(con, "airquality", airquality, overwrite = TRUE)

# # 4. 查看表
# dbListTables(con)
# dbReadTable(con, "airquality")

# # 5. 断开连接
# dbDisconnect(con)

library(httr)
res <- httr::GET("https://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/all")
status_code(res)  # 看返回 200 还是 404