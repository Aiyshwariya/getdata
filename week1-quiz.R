## Week 1 Quiz

## Check if data subdirectory exists
if(!file.exists("./data")) {
    dir.create("./data")
}

##### Question 1 #####

csvURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
## download the file into ID-housing.csv
download.file(csvURL, destfile = "./data/ID-housing.csv", method = "curl")
dateCSVDownloaded <- date()

## read csv file into memory
housingData <- read.csv("./data/ID-housing.csv")
## calculate number of rows of a subset containing only properties with VAL = 24
overMillion <- nrow(subset(housingData, housingData$VAL == 24))

##### Question 3 #####

## load the lib
library(xlsx)

xlsURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(xlsURL, destfile = "./data/NGAP.xlsx", method = "curl")
dateXLSDownloaded <- date()

## read a subset of XLS file into memory
colIndex <- 7:15
rowIndex <- 18:23
NGAPData <- read.xlsx("./data/NGAP.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)

## Dow the useless summing as quiz instructs
quiz2sum <- sum(NGAPData$Zip*NGAPData$Ext,na.rm=T)


##### Question 4 #####

## load the lib
library(XML)
xmlURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
dateXMLDownloaded <- date()
download.file(xmlURL, destfile = "./data/restaurants.xml", method = "curl")
## parse XML file
restData <- xmlTreeParse("./data/restaurants.xml", useInternal = T)
rootRestNode <- xmlRoot(restData)

## create a vector with just the zipcodes
zipcodes <- xpathSApply(rootRestNode, "//zipcode", xmlValue)
## length a vector where zipcode matches "21231"
length(which(zipcodes == "21231"))

##### Question 5 #####
library(data.table)
library(microbenchmark)
csv2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
## download the file into ID-housing.csv
download.file(csv2URL, destfile = "./data/ID-housing2.csv", method = "curl")
dateCSV2Downloaded <- date()

## read csv file into memory
DT <- fread("./data/ID-housing2.csv")