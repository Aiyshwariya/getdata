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

## replace commas with nothing with gsub, convert to numeric and calculate mean
mean(as.numeric(gsub(",", "", gdpData$V5)))

### ANSWER 2. [1] 377652.4