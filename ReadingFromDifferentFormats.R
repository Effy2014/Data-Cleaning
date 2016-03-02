setwd("/Users/XW/Desktop")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "/Users/XW/Desktop/data.csv")
data <- read.csv("data.csv", header = T)
subdata <- subset(data, VAL == 24)
#read excel data
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "data.xlsx", method = "curl")
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("data.xlsx", 1, colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

#read XML data
library(XML)
library(RCurl)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(fileUrl)
doc <- xmlParse(xData, useInternal = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipcode = xpathSApply(doc, "//zipcode", xmlValue) 
length(zipcode[zipcode == 21231])
#read large dataset
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "data2.csv")
DT <- fread("data2.csv")
DT[,mean(pwgtp15), by=SEX]
