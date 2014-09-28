### QUESTION 1. Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fileName <- tempfile()
download.file(fileURL, fileName, method = "curl")

data <- read.csv(fileName)

strsplit(names(data), "\\wgtp")[123]

### ANSWER 1. [1] ""   "15"