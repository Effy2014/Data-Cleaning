library(jpeg)
Url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(Url, destfile = "img.jpg")
img <- readJPEG("img.jpg", native = TRUE)
quantile(img, probs = c(0.3, 0.8))


fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, "GDP.csv")
download.file(fileUrl2, "edu.csv")
GDP <- read.csv("GDP.csv", header = F, skip = 5, blank.lines.skip=T, nrows = 190)
EDU <- read.csv("edu.csv", header = T)
inner <- merge(GDP, EDU, by.x = "V1", by.y = "CountryCode", all = F)
dim(inner)
sorted <- arrange(GDP, desc(V2))
outer <- merge(GDP, EDU, by.x = "V1", by.y = "CountryCode", all = T)
outer %>% group_by(Income.Group) %>% summarize(mean(V2, na.rm = T))

outer$rank <- cut(outer$V2, breaks=quantile(outer$V2, n = 5, na.rm = T))
table(outer$Income.Group, outer$rank)
which(outer$Income.Group == "Lower middle income" & outer$V2 <=38)
