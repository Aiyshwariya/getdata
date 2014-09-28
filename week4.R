#### EDITING TEXT VARIABLES ####

#fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
#destFile <- tempfile()
#download.file(fileURL, destFile, method = "curl")

cameraData <- read.csv("./data/cameras.csv")

names(cameraData)
tolower(names(cameraData))

## Splitting variable names by dot
splitNames = strsplit(names(cameraData), "\\.")
splitNames[[5]]
splitNames[[6]]

myList <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(myList)

myList[1]
myList$letters
myList[[1]]

splitNames[[6]][1]

firstElement <- function(x) {
    x[1]
}

sapply(splitNames, firstElement)

#fileURL1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
#fileURL2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
#download.file(fileURL1, destfile = "./data/reviews.csv", method = "curl")
#download.file(fileURL2, destfile = "./data/solutions.csv", method = "curl")

reviews <- read.csv("./data/reviews.csv")
head(reviews, 2)
solutions <- read.csv("./data/solutions.csv")
head(solutions, 2)

names(reviews)
sub("_", "", names(reviews))

testName <- "this_is_a_variable"
sub("_", "", testName)
gsub("_", "", testName)

## Which of the elements that have "Alameda"?
grep("Alameda", cameraData$intersection)
## Show actual values
grep("Alameda", cameraData$intersection, value = T)

grep("Jackson", cameraData$intersection)
length(grep("Jackson", cameraData$intersection))

## Show results in table
table(grepl("Alameda", cameraData$intersection))

## Subset with grepl
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]

library(stringr)
nchar("Pavlushka Rebrov")
substr("Pavlushka Rebrov", 1, 9)
paste("Pavlushka", "Rebrov")
paste0("Pavlushka", "Rebrov") ## without space
str_trim("Pavlushhka              ")