### QUESTION 1. Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fileName <- tempfile()
download.file(fileURL, fileName, method = "curl")

data <- read.csv(fileName)

strsplit(names(data), "\\wgtp")[123]

### ANSWER 1. [1] ""   "15"

### QUESTION 2. Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 

gdpURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdpFile <- "./data/GDP.csv"
download.file(gdpURL, gdpFile, method = "curl")

gdpData <- read.csv(gdpFile, skip = 5, nrows = 190, stringsAsFactors = F, header = F)
gdpData <- gdpData[, c(1, 2, 4, 5)]
colnames(gdpData) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")

## replace commas with nothing with gsub, convert to numeric and calculate mean
mean(as.numeric(gsub(",", "", gdpData$GDP.Value)))

### ANSWER 2. [1] 377652.4

### QUESTION 3. In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

length(grep("^United",gdpData$Country.Name))

### ANSWER 3. [1] 3

### QUESTION 4. Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June? 
eduData  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
eduFile <- "./data/EDU.csv"
download.file(eduData, eduFile, method = "curl")

eduData <- read.csv(eduFile, stringsAsFactors = F)
eduData <- eduData[, c("CountryCode", "Special.Notes")]

mergedData <- merge(gdpData, eduData, as.x = "CountryCode", as.y = "CountryCode")
## Fiscal Year data is stored in Special.Notes. Find how many of 'em have "Fiscal year end June"
length(grep("[Ff]iscal year end(.*)+June", mergedData$Special.Notes))

### ANSWER 4. [1] 13

### QUESTION 5. How many values were collected in 2012? How many values were collected on Mondays in 2012?

## You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
library(lubridate)
library(quantmod)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

sampleTimes = ymd(sampleTimes)round_date(sampleTimes, "year")

## Subset observations made in 2012
Y2012 <- subset(sampleTimes, year(sampleTimes) == 2012)
length(Y2012) ## [1] 250
## Find out number of Mondays in this subset
length(which(wday(Y2012, label = T) == "Mon")) ## [1] 47