####################################################################################################
# csv file
######################################################################################################
data1 <- read.csv("C:/Users/arun/Desktop/Tertiary courses/Advance R/Heart11.csv", header = TRUE)

data=read.csv(file.choose(), header=TRUE)

### view data
View(data1)
head(data1)
summary(data1)
str(data1)
levels(data1$ChestPain)
data1$cp=factor(data1$ChestPain)

write.csv(data1, file = "redata1.csv", quote = FALSE, row.names = FALSE)
getwd()



data2 <- read.table("data1.csv", header = TRUE, sep = ",")
head(data2)
write.table(data2, file = "redata2.csv", quote = FALSE, row.names = FALSE, sep = ",")

#######################################################################################################
# JSON file
#######################################################################################################
install.packages("jsonlite")
library(jsonlite)

employees.json <- '{
  "employees":[
  {"firstName":"John", "lastName":"Doe"},
  {"firstName":"Anna", "lastName":"Smith"},
  {"firstName":"Peter", "lastName":"Jones"}
  ]
  }'

employee <- fromJSON(employees.json)  # read in the string
employee
names(employee)
employee$employees

jsonIris <- toJSON(iris[1:3,], pretty = TRUE)
jsonIris
fromJSON(jsonIris)

write(jsonIris, file = "iris.json")  # write json data to a file
fromJSON("iris.json")                # read json data from a file

###########################################################################################################
## XML file
###########################################################################################################
employee.xml <- '<employees>
    <employee>
        <firstName>John</firstName> <lastName>Doe</lastName>
    </employee>
    <employee>
        <firstName>Anna</firstName> <lastName>Smith</lastName>
    </employee>
    <employee>
        <firstName>Peter</firstName> <lastName>Jones</lastName>
    </employee>
</employees>'

install.packages("XML")
library(XML) 
employee <- xmlTreeParse(employee.xml)
names(employee)
employee$doc

class(employee)

xmltop <- xmlRoot(employee)
xmltop[2]

empName <- xmlSApply(xmltop, function(x) xmlSApply(x, xmlValue))
empName

empNameDf <- data.frame(t(empName), row.names = NULL)
empNameDf


#########################################################################################################
# Reading data from web
#########################################################################################################
browseURL("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
wine=read.table(url, nrows=5, header = FALSE, sep = ",")

## Challenge: download the boston housing dataset and save it under the name house
boston <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"

