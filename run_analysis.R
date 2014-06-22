## clear memory
rm(list=ls())

# File download and unzip

## parameters input
CodeDir = "E:\\Dropbox\\Data Science Coursera\\Getting and Cleaning Data\\Project\\Wearable-Computing"
setwd(CodeDir)  ## Code directory
fileDir <- "./data"
filename <- "Dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filefullname <- paste(fileDir,filename,sep="/")

## download file if not exist
if (!file.exists(filefullname)){
        
        if(!file.exists(fileDir)){dir.create(fileDir)}  ## create directory if not exist
        download.file(fileUrl,destfile=filefullname)
        
}

## unzip file
unzip(filefullname,exdir=fileDir)
dataDir <- paste(fileDir,"UCI HAR Dataset",sep="/")

setwd(dataDir)

## Read data
activity_labels <- read.table("activity_labels.txt",col.names=c("activityID","activityName"))
feature_labels <- read.table("features.txt",col.names=c("featureID","featureName"),colClasses=c("numeric","character"))

## Part 2 and Part 4, extract only measurements on the mean and standard deviation
## and name the column appropiately

## feature_labels$included indicate which feature to include
## Use "|" instead of "||" to return a vector
feature_labels$included <- grepl("mean()",feature_labels$featureName, fixed=TRUE) | 
                           grepl("std()",feature_labels$featureName, fixed=TRUE)

## Name for the column in X, eliminate "()", replace "-" with "."
feature_labels$col.name <- ifelse(feature_labels$included,gsub("()","",feature_labels$featureName,fixed=TRUE),"NULL") 
feature_labels$col.name <- gsub("-",".",feature_labels$col.name)
## type for the column in X, NULL means skip the column
feature_labels$col.type <- ifelse(feature_labels$included,"numeric","NULL") 



y_train <- read.table("./train/y_train.txt",col.names="activityID")
y_test <- read.table("./test/y_test.txt",col.names="activityID")

subject_train <- read.table("./train/subject_train.txt",col.names="SubjectID")
subject_test <- read.table("./test/subject_test.txt",col.names="SubjectID")

## colClasses make sure that only mean and std of measurement is included
## col.names assign appropiate name to each column
x_train <- read.table("./train/x_train.txt",col.names=feature_labels$col.name, colClasses=feature_labels$col.type)
x_test <- read.table("./test/x_test.txt",col.names=feature_labels$col.name, colClasses=feature_labels$col.type)

## Part 1, Merge training and testing data
y_com <- rbind(y_train,y_test)  ## complete y dataset, combine train and test data
subject_com <- rbind(subject_train, subject_test)  ## complete subject dataset
x_com <- rbind(x_train,x_test)  ## complete x dataset

## combine subject, y and x
complete_data <- cbind(subject_com,y_com,x_com)

## Part 3, use descriptive acivity names to name the activities
## Use names in activity_labels.txt
complete_data <- merge(complete_data,activity_labels)


## Part 5, create tidy data and output it to relevant file
## use plyr to???produce tidy data. Could use other methods, please refer to commented code.
library(plyr)
## numcolwise apply a function to all numeric column
tidy_plyr <- ddply(complete_data, .(activityID,SubjectID,activityName),numcolwise(mean))  ## pass cross check in excel!
setwd(CodeDir)
write.table(tidy_plyr,file="tidy.txt",row.names=FALSE)
write.csv(tidy_plyr,file="tidy.csv",row.names=FALSE)



## Alternative method using data table instead of plyr
# library(data.table)
# complete_data_dt <- data.table(complete_data)
# ## .SD mean all column except one in side by. 
# tidy_dt <- complete_data_dt[,lapply(.SD, mean), by =  list(activityID,SubjectID, activityName) ]
# ## reorder the data by activityID first, then SubjectID
# tidy_dt <- tidy_dt[order(activityID, SubjectID)]

# write.table(tidy_dt,file="tidy_dt.txt",row.names=FALSE)
# write.csv(tidy_dt,file="tidy_dt.csv",row.names=FALSE)


## relevant website: http://stackoverflow.com/questions/10787640/ddply-summarize-for-repeating-same-statistical-function-across-large-number-of
## data table: https://github.com/raphg/Biostat-578/blob/master/Advanced_data_manipulation.Rpres
## plyr tutorial: http://plyr.had.co.nz/09-user/
## reshape tutorial: http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
## plyr primer: http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/

