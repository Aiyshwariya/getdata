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


##### CREATING NEW VARIABLES #####

## Creating sequences, they are often used to create indeces

## Create sequence 1 through 10, increasing each value by 2
s1 <- seq(1, 10, by = 2); s1
## Create sequence 1 through 10, of 3 elements
s2 <- seq(1, 10, length = 3); s2
## Create an index of a vector
x <- c(1, 3, 8, 25, 100); seq(along = x)

## Subset restaurants that are in one of the neighborhoods ("Roland Park" or "Homeland"), save as new variable nearMe in restData
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
## restData$nearMe now allows me to subset restData by proximity near me. Essentialy it's a shortcut to longer %in% command above.
table(restData$nearMe)

## Creating binary variables
## Store negative zip codes as TRUE value of zipWrong, all others are TRUE value of zipWrong
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
## Create a 2-dim table of stored zipWrongs vs zipCode < 0
table(restData$zipWrong, restData$zipCode < 0)

## Creating categorical variables, breaking quantitative variable into categorical
## Create factor variable zipGroups by cutting zipCode vector by quantiles of zipCode
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
## Show zipGroups as table, it's a cumulitive number of zipCodes factored by zipGroups
table(restData$zipGroups)
## Show zipGroups as a distribution of zipCode values over their quantiles
table(restData$zipGroups, restData$zipCode)

## Cutting using Hmisc packages
library(Hmisc)

## use cut2 to cut zipCode vector into 4 zipGroups by their quantiles
restData$zipGroups = cut2(restData$zipCode, g = 4)
## Note that it'll find out the actual quantiles and break up the vector
table(restData$zipGroups)

## Creating factor variables
## Turn zipCode integer variable into factor variable zcf
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
summary(restData$zcf)
class(restData$zcf)

## Create a dummy vector filled with "yes" and "no"
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
## Create factor variable and set "yes" as the lowest value thus ordering factors. By default it would treat first alphabetically as the lowest.
yesnofac <- factor(yesno, levels = c("yes", "no"))
## re-order levels of factor to start with "yes". In this particular case identical to levels = in factor function.
relevel(yesnofac, ref = "yes")
## factors can be changed to numeric values, first starts as 1 and then they increment by 1
as.numeric(yesnofac)

## Use mutate from plyr and cut2 from Hmisc to create a new data frame that is an old data frame restData with added new variable zipGroups that is a cut2 function o zipCode (of original restData)
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

##### RESHAPING DATA #####
library(reshape2)

head(mtcars)

## Melting the data set
## Add rownames (they are car names) into a separate column as variable carname
mtcars$carname <- rownames(mtcars)
## Melt the dataset, carname, gear and cyl are id variable and kept as they are, mpg and hp are measure variables, they are melted. mpg and hp are in variable column now
carMelt <- melt(mtcars,
                id = c("carname", "gear", "cyl"),
                measure.vars = c("mpg", "hp"))

head(carMelt, n = 3)
tail(carMelt, n = 3)

## Re-casting the data set
## by default dcast summarises data by length. This will show number of observations of each of melted variables for cylinders
cylData <- dcast(carMelt, cyl ~ variable)
cylData
## Summarise melted variables by their means across number of cylinders
cylData1 <- dcast(carMelt, cyl ~ variable, mean)
cylData1

head(InsectSprays)
## Count the number of insects for each type of spray (apply given function to variables iterated by Index)
tapply(InsectSprays$count, InsectSprays$spray, sum)

## Split counts by each of the sprays
spIns = split(InsectSprays$count, InsectSprays$spray)
str(spIns)
## Apply a function sum to the list spIns
sprCount = lapply(spIns, sum)
str(sprCount)
## Combine a list into a vector
unlist(sprCount)
## sapply combines lapply + unlist and returns a vector
sapply(spIns, sum)

## Do the same with plyr, combine split + apply + combine
## InsectSpray is the data frame, .(spray) is a variable that we want to summarise, equivalent to "spray"
## summarise - function1, we want to summarise the variable.
## sum - function2, saying exactly how we want to summarise it and that we want to name the variable sum
ddply(InsectSprays, .(spray), summarise, sum = sum(count))
## Summarise by mean
ddply(InsectSprays, "spray", summarise, varColName = mean(count))
## Substract off the total count from actual count for every variable
spraySums <- ddply(InsectSprays, .(spray), summarise, sum = ave(count, FUN = sum))
## It's the same size as the original data set
dim(spraySums)
## And now for each spray (A, B, C, D, etc.) we have a total sum of value for A, B, C, D, etc. So for each spray == A, sum is a sum of all Insects for spray A.
head(spraySums)

