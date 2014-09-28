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

##### REGULAR EXPRESSIONS #####

## ^LITERALS — matches "LITERALS" at the beginning of the line
## LITERALS$ — matches "LITERALS" at the end of the line
## [Bb][Uu][Ss][Hh] — sets of characters, matches "Bush", "bUsh", "BuSh", etc.
## ^[Ii] am — "I" or "i" followed by "am", at the beginning of the line
## ^[0-9][a-zA-Z] - lines starting with any number and followed by any letter
## [^?.]$ - lines ending with anything other then "." or "?". ^ in set means "NOT"

## . as metacharacters means "ANY CHARACTER"
## 9.11 matches "9" separated by any character from "11" — "9-11", "9:11", "9 11", but not "911"
## | - OR. fire|flood|hurricate|tornado
## ^[Gg]ood|[Bb]ad - matches "Good", "good" in the beginning of the line OR "Bad", "bad" anywhere in the line.
## () — AND
## ^([Gg]ood|[Bb]ad) — "Good", "good", "Bad" or "bad" at the beginning of the line.
## ? - optional
## [Gg]eorge( [Ww]\.)? [Bb]ush - matched "George Bush" with and optional " W." in the middle, dot is escaped.
## * - repeat any number of times, including none.
## + - at least one of the item
## (.*) - any character repeated any number of times.
## [0-9]+ (.*)[0-9]+ - at least one digit divided by any character, non-number (including none) from another at least one digit. "01", "0 asd asd asd as 1", "144 99"
## {} - minimum and maxim number of matches
## [Bb]ush( +[^ ]+ +){1,5} debate - "Bush" and "debate" with at least one space, followed by at least one non-space, followed by at least one space, between 1 and 5 times. 1-5 words between "bush" and "debate".
## {x, y} - at least x times, at most y times.
## {x} - exactly x times
## {x, } - at least x times
## () and \1, \2 — "saved search"
##  +([a-zA-Z]+) +\1 + — space followed by one or more characters followed by at least one space followed by match in (). Looking for repetition of the match.

##### WORKING WITH DATES #####
d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)

format(d2, "%a, %b %d")

x = c("1jan2013", "1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1] - z[2])

weekdays(d2)
months(d2)
julian(d2)

library(lubridate)
ymd("20140812")
mdy("05/03/1994")
dmy("5-5-1980")
ymd_hm("2012-04-02 11:44")
ymd_hms("2012-04-02 11:44:59", tz = "Asia/Singapore")

x1 = dmy(x)
wday(x1[1])
wday(x1[1], label = T)