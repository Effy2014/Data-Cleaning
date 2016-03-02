con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[[10]])

library(XML)
url = "http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url, useInternalNodes = T)
#xpathSApply(html, "", xmlValue)

library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parseHtml = htmlParse(content2, asText = T)
#xpathSApply(parseHtml, "", xmlValue)