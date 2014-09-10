############ QUESTION 1 #############

library(httr)
library(httpuv)
library(jsonlite)

## Set that we're using GitHub
oauth_endpoints("github")
## Create an application and authorize
myApp <- oauth_app("github",
                  key = "977dd76419507c18a825",
                  secret = "35ea2b697d14caef2a76ac7c6e20b4f4ca93539d")
## Get access token
github_token <- oauth2.0_token(oauth_endpoints("github"), myApp)

## Pass settings to CURL
gtoken <- config(token = github_token)

## Instructor's repos are here, get 'em
repos = GET("https://api.github.com/users/jtleek/repos", gtoken)
## Make sure we don't get an error
stop_for_status(repos)

## Parse received data into an R object
jsonTemp = content(repos)
## Parse R object into JSON and then as a data frame from resulting JSON
json = fromJSON(toJSON(jsonTemp))

## Find date of creation of "datasharing" repo
json[json$name == "datasharing", "created_at"]

#### Alternative from http://nbviewer.ipython.org/github/mirjalil/DataScience/blob/master/R_gettingData.ipynb ######

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
jsonData[jsonData$name == "datasharing", "created_at"]

############ QUESTION 2 #############
library(sqldf)

## create temporary file
temporaryFile <- tempfile()
## download CSV into temporary file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = temporaryFile, method = "curl")
## read temporary file. it could have worked directly with URL if it wasn't https
read.csv(temporaryFile)


sqldf("select pwgtp1 from acs where AGEP < 50")

######### QUESTION 3 ########
length(unique(acs$AGEP))
sqldf("select distinct AGEP from acs")



######### QUESTION 4 ########
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
## Read html file line by line
htmlCode <- readLines(con)
close(con)

## number of character in lines 10, 20, 30, 100
nchar(htmlCode[c(10, 20, 30, 100)])

######### QUESTION 5 ########
wksst <- read.fwf(
    file = url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for "),
    skip = 4,
    widths = c(12, 7,4, 9,4, 9,4, 9,4))

sum(wksst[, 4])