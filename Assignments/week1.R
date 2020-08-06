#---- HEADER ----
#--- Name: week1

#--- Purpose: Answer the Coursera Getting and Cleaning Data

#--- Author: Moses Otieno

#--- Date: 06Aug2020

#---- Download the files ----

#---- Libraries ----
library(RCurl)
library(tidyverse)
library(xlsx)
library(XML)
library(data.table)



#--- Create the folders if they are not created already

if(!file.exists("./Assignments/data")){dir.create("./Assignments/data")}
if(!file.exists("./Assignments/codebook")){dir.create("./Assignments/codebook")}


#--- Set the urls for downloads
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

#--- Download the data and the codebook
download.file(url, "./Assignments/data/fsshd.csv")
download.file(url2, "./Assignments/codebook/fssh.pdf")
download.file(url3, "./Assignments/data/FDATA.gov_NGAP.xlsx", mode='wb')
download.file(url5, "./Assignments/data/Fss06pid.csv")
Frestaurants <- xmlTreeParse(sub("s", "", url4), useInternal = TRUE)


#--- You can use the library RCurl to download the files
fsshd <- getURL(url)
fsshd <- read.csv(textConnection(fsshd))

Fss06pid <- getURL(url5)
Fss06pid <- read.csv(textConnection(Fss06pid))
Fss06pid


#---- Question one: csv files ----

fsshd <- as_tibble(fsshd)

glimpse(fsshd)

fsshd %>%
  select_if(is.numeric)

fsshd %>%
  select(VAL) %>%
  count(VAL) %>%
  print(n=25)


#---- Question three: EXcel files ----

xcelfile <- "./Assignments/data/FDATA.gov_NGAP.xlsx"
rows_index <- 18:23
cols_index <- 7:15

dat <- xlsx::read.xlsx2(xcelfile, 1, colIndex = cols_index, startRow = 18, endRow = 23)

dat <- as_tibble(dat)

glimpse(dat)

dat <- dat %>%
  mutate_at(vars(Zip, Ext), as.numeric)

sum(dat$Zip*dat$Ext,na.rm=T)


#--- Question four: XML ----
rootNode <- xmlRoot(Frestaurants)
xmlName(rootNode)
names(rootNode)


xmlSApply(rootNode, xmlValue)
xpathSApply(rootNode, "//zipcode",xmlValue)

table(xpathSApply(rootNode, "//zipcode",xmlValue))


#---- Question five: data.table ----

DT <- fread("./Assignments/data/Fss06pid.csv")


DT %>%
  select(pwgtp15)


DT <- lapply(DT, as.numeric)


rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]

system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))

system.time(tapply(DT$pwgtp15, DT$SEX, mean))

mean(DT[DT$SEX==1, ]$pwgtp15)

DT[DT$SEX==1,]$pwgtp15

DT[DT$SEX==1]


system.time(mean(DT$pwgtp15, by = SEX))
