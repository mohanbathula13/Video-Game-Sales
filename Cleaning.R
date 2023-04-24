install.packages("openxlsx")
install.packages("devtools")
devtools::install_github("tylermorganwall/rayshader")
library(openxlsx)
library(dplyr)

data_2015_2023$genre <- ifelse(grepl("<", data_2015_2023$genre),
                   sub("^[^<]*<(.*)", "\\1", data_2015_2023$genre),
                   data_2015_2023$genre)

sum(grepl("<", data_2015_2023$genre))

data_2015_2023$genre <- substr(data_2015_2023$genre, nchar(data_2015_2023$genre)-2, nchar(data_2015_2023$genre))

write.xlsx(data_2015_2023, file="D:/USF/SDM/Project/Dataset/Final_Data.xlsx", rowNames = FALSE)

data_2015_2023$title <- gsub("#$", "", data_2015_2023$title)

data_2015_2023$Blockbuster <- ifelse(data_2015_2023$rank == 1, 1, 0)

data_2015_2023$weekly_sales <- as.numeric(data_2015_2023$weekly_sales)

data_2015_2023$week_no <- as.Date(data_2015_2023$week_no, format = "%Y-%m-%d")



Final_Data$price <- as.numeric(gsub("\\.", "", Final_Data$price))


# Remove"." from units sold column
Final_Data$weekly_sales <- as.numeric(gsub("\\.", "", Final_Data$weekly_sales))
Final_Data$Total_weekly_sales <- Final_Data$weekly_sales * Final_Data$price
Final_Data <- Final_Data %>%
  group_by(week_no) %>%
  mutate(sum_sales = sum(Total_weekly_sales))
Final_Data$weekly_market_share<- ((Final_Data$Total_weekly_sales/Final_Data$sum_sales)*100)


write.xlsx(Final_Data, file="D:/USF/SDM/Project/Dataset/Final_Data.xlsx", rowNames = FALSE)
