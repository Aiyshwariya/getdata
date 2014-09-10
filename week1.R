## Week 1 exercises

## Check if data subdirectory exists
if (!file.exists("data")) {
    dir.create("data")
}

## store URL
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
## download file into ./data/cameras.csv
download.file(fileURL, destfile = "./data/cameras.csv", method = "curl")
## store the date of download
dateDownloaded <- date()
## read data from file, specify comma as a separator and that it has a header row
## read.csv(filename) = read.table(filename, sep = ",", header = T)
cameraData <- read.table("./data/cameras.csv", sep = ",", header = T)

