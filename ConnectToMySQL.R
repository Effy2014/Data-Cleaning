library(RMySQL)
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb)
hg19 <-dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
dbListFields(hg19, "affyU133Plus2") #column names
dbGetQuery(hg19, "select count(*) from affyU133Plus2") #count of rows

affData <- dbReadTable(hg19, "affyU133Plus2")
#subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affMis <- fetch(query)

affyMisSmall <- fetch(query, n=10); dbClearResult(query)
dbDisconnect(hg19)
