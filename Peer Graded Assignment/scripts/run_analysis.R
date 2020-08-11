#---- Header  -----

#---- Name : run_analysis

#---- Purpose : Answer the Peer graded questions from Coursera Getting and cleaning Data Module

#---- Author: Moses Otieno

#---- Date : 11 Aug 2020


#---- Body -----

#---- Libraries

library(tidyverse)



#---- Download data

urlsmartphone <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


#---- Download the file if it does not exist
if (!file.exists("./Peer Graded Assignment/data/Dataset.zip")){

download.file(urlsmartphone, destfile = "./Peer Graded Assignment/data/Dataset.zip")
}

#---- Unzip the file
unzip("./Peer Graded Assignment/data/Dataset.zip",exdir = "./Peer Graded Assignment/data")




