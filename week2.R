############ MYSQL #############

library(RMySQL)

## Connect to genome-mysql.cse.ucsc.edu MySQL
#ucscDb <- dbConnect(MySQL(), user = "genome",
#                    host = "genome-mysql.cse.ucsc.edu")
## retrieve list of databases
#result <- dbGetQuery(ucscDb, "show databases;")
## Disconnect
#dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(), user = "genome",
                  host = "genome-mysql.cse.ucsc.edu",
                  db = "hg19")
allTables <- dbListTables(hg19)

## List table columns
dbListFields(hg19, "affyU133Plus2")
## Count number of rows in a table
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

affyData <- dbReadTable(hg19, "affyU133Plus2")
dim(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

affyMis <- fetch(query); quantile(affyMis$misMatches)
dim(affyMis)

affyMisSmall <- fetch(query, n = 10); dbClearResult(query)
dim(affyMisSmall)

dbDisconnect(hg19)



############# HDF5 ###############
library(rhdf5)

created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "bar")
created = h5createGroup("example.h5", "foo/foobar")

h5ls("example.h5")

A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")

B = array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobar/B")
h5ls("example.h5")

df = data.frame(1L:5L, seq(0, 1, length.out = 5),
                c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = F)
h5write(df, "example.h5", "df")

readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobar/B")
readdf = h5read("example.h5", "df")


############ READING FROM THE WEB #############

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = T)
xpathSApply(parsedHtml, "//title", xmlValue)

pg1 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user", "passwd"))
names(pg1)


############ READING FROM THE API #############

library(jsonlite)

myApp = oauth_app("twitter",
                  key = "Hb6tLAAXhOzlaVIXuR9UCwqjf",
                  secret = "A2enhZGtiOjiIuKA5HljUxwE07wAADzcFyPHSCYeOaCPFFD03O")
sig = sign_oauth1.0(myApp,
                    token = "5536012-y0elvrCEQmNamJfnvU3jir1ShjQqbrhcmzkHHrYEid",
                    token_secret = "B5H0l43zE4J6X6wkQRxHmCaiqWA1uSpD82C99IQ1VLGp8")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL)
json2 = fromJSON(toJSON(json1))