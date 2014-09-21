##### SUBSETTING AND SORTING #####

set.seed(13435)

X <- data.frame("var1" = sample(1:5),
                "var2" = sample(6:10),
                "var3" = sample(11:15))
X <- X[sample(1:5), ]
X$var2[c(1,3)] = NA

## Subset rows with var1 <=3 AND var3 > 11
X[(X$var1 <= 3 & X$var3 > 11), ]

## Subset rows where var2 > 8 and omit NAs
X[which(X$var2 > 8), ] ## Compare to X[(X$var2 > 8), ]

## Sort var2 column, descending order and put NAs last
sort(X$var2, na.last = T, decreasing = T)

## Sort X by order of var1 and var3
X[order(X$var1, X$var3), ]

library(plyr)

## Sort X by order of var1 with PLYR
arrange(X, var1)
arrange(X, desc(var1))

## Add a column named var4
X$var4 <- rnorm(5)

## Do the same with cbind and save into a new data frame
Y <- cbind(X, rnorm(5))

##### SUMMARIZING DATA #####
if(!file.exists("./data") {
    dir.create("./data")
})

fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")

## Show top 3 rows
head(restData, n = 3)
## Show bottom 3 rows
tail(restData, n = 3)
## Show summary of the data frame
summary(restData)
## Show structure of the data frame
str(restData)
## Show quantiles of counsilDistrict variable
quantile(restData$councilDistrict, na.rm = T)
## Show quantiles of counsilDistrict at 50%, 75% and 90% probabilities
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
## Build a table for zipCode variable, shows zipCodes and their number of their occurence. Will add a column for NA values
table(restData$zipCode, useNA = "ifany")
## Two-dimensional table
table(restData$counsilDistrict, restData$zipCode)
## check for number of missing values: is.na returns 1 if value is missing, sum 'em up and you get total number of NAs
sum(is.na(restData$councilDistrict))
## check is there are any missing values in the vector at all. any returns true if any of the input is true
any(is.na(restData$councilDistrict))
## check if all the values are greater than 0
all(restData$zipCode > 0)
## colSums calculates sums for every column, so we'll use it to calculate number of NA values in each column
colSums(is.na(restData))
## Check if number of NAs in each columns is zero (means there are no NA values)
all(colSums(is.na(restData)) == 0)

## Build table of how many variables (zipCode) satisfy the condition (are within range provided, "21212" and "21212" + "21213")
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
## Get only the restaurants that have a zipCode either "21212" or "21213"
restData[restData$zipCode %in% c("21212", "21213"), ]

## Load UC Berkley admissions data set
data(UCBAdmissions)
## Load it as data frame
DF = as.data.frame(UCBAdmissions)
## Show summary of the data frame
summary(DF)
## Cross tabulate data by showing Freq variable and breaking it down by Gender and Admit
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

## warpbreaks is another standard included data set.
## create new column in the data frame, fill it with 1 through 9 54 times
warpbreaks$replicate <- rep(1:9, len = 54)
## Create cross-tabs of breaks variable, broken down by all other variables
xt = xtabs(breaks ~ ., data = warpbreaks)
xt
## see it as a flat table
ftable(xt)

## Generate fake data set
fakeData = rnorm(1e5)
## Calculate the size of the data set 
object.size(fakeData)
## Show size in other units
print(object.size(fakeData), units = "Mb")