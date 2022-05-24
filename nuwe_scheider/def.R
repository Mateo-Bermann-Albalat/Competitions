# First, we load the necessary libraries 
library(readr)
library(jsonlite)
library(dplyr)
library(pdftools)
library(tidyverse)
# The CSV were downloaded from the challenge page and since the files are in the project folder, there's no need to open the full path
train1<- read_csv("train1.csv")
train2 <- read_delim("train2.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
# The JSON files were downloaded from the API
train3 <- fromJSON("http://schneiderapihack-env.eba-3ais9akk.us-east-2.elasticbeanstalk.com/first")
train4 <- fromJSON("http://schneiderapihack-env.eba-3ais9akk.us-east-2.elasticbeanstalk.com/second")
train5 <- fromJSON("http://schneiderapihack-env.eba-3ais9akk.us-east-2.elasticbeanstalk.com/third")
test_x <- read.csv("test_x.csv")
# Unimos los datos de csv y jsons cada uno por su cuenta
csvs <- rbind(train1, train2)
jsons <- rbind(train3, train4, train5)
# Recortamos las columnas de los códigos de los jsons
jsons <- jsons[,c(-1,-7,-9)]
# Y hacemos un dataframe con todos los datos 
train <- rbind(csvs, jsons)
train <- train[, c(-7, -12)]
train$pollutant <- as.factor(train$pollutant)
train$countryName <- as.factor(train$countryName)
train$eprtrSectorName <- as.factor(train$eprtrSectorName)
train$EPRTRAnnexIMainActivityLabel <- as.factor(train$EPRTRAnnexIMainActivityLabel)
train$FacilityInspireID <- as.factor(train$FacilityInspireID)
train$reportingYear <- as.numeric(train$reportingYear)
train$MONTH <- as.numeric(train$MONTH)
train$facilityName <- as.factor(train$facilityName)
train$City <- as.factor(train$City)
train$DAY <- as.numeric(train$DAY)
train$max_wind_speed <- as.numeric(train$max_wind_speed)
train$avg_wind_speed <- as.numeric(train$avg_wind_speed)
train$min_wind_speed <- as.numeric(train$min_wind_speed)
train$max_temp <- as.numeric(train$max_temp)
train$avg_temp <- as.numeric(train$avg_temp)
train$min_temp <- as.numeric(train$min_temp)
train$`DAY WITH FOGS` <- as.factor(train$`DAY WITH FOGS`)
train$`REPORTER NAME` <- as.factor(train$`REPORTER NAME`)
train$ `CITY ID` <- as.factor(train$`CITY ID`)
train_sample_nums <- sample(1:nrow(train), 50000)
train_validation <- train[-train_sample_nums,]
train_sample <- train[train_sample_nums,]
train_cols <- train[,c(5,6,7,8,9,11,14,16)]
train_cols2 <- train_cols[-train_sample_nums,]
write.csv(train, "D:/RSTUDIO/Hackaton/train.csv", row.names = FALSE)

