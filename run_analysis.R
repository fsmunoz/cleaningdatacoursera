## Coursera - Getting and Cleaning Data
## Course Project
##
## Author: Frederico Munoz <fsmunoz@gmail.com>
##
## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##  You should create one R script called run_analysis.R that does the following. 
##  - Merges the training and the test sets to create one data set.
##  - Extracts only the measurements on the mean and standard deviation for each measurement. 
##  - Uses descriptive activity names to name the activities in the data set
##  - Appropriately labels the data set with descriptive activity names. 
##  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## This script assumes a locally unzipped dataset
## Uses the reshape2 library for melt/cast
library(reshape2)

## Import datasets and merge them
X.traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
X.testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
X.data <- rbind(X.testdata, X.traindata) # merge
Y.traindata <- read.table("./UCI HAR Dataset/train/y_train.txt")
Y.testdata <- read.table("./UCI HAR Dataset/test/y_test.txt")
Y.data <- rbind(Y.testdata, Y.traindata) # merge

## Import the features and activities
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2]))) # as found in the forum...

## Read and merge subjects
sub.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
sub.data <- rbind(sub.train, sub.test) # merge

## Extract the mean and SD, and add the appropriate label
Y.data [,1] = activities[Y.data[,1], 2]
names(Y.data) <- "activity"
meanSD.features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X.data.meanSD<-X.data[,meanSD.features]
names(X.data.meanSD)<-tolower(gsub("\\(|\\)", "", features[meanSD.features, 2])) # idem, gsub seems like bruteforcing though

## Do the labelling on the subject data and create tmp dataset for
## further processing with reshape2 (but which is already merge)
names(sub.data) <- "subject"
tmp.dataset<- cbind(sub.data, Y.data, X.data.meanSD)
write.table(tmp.dataset, "temp_data.txt")

## Some real magic using melt/dcast of the reshape2 library, which
## creates the final data. melt takes wide-data and melts it into
## long-format data, and castthe opposite (dcast is for data frames)
melted.data <- melt(tmp.dataset, id=c("subject","activity"))
final.data <- dcast(melted.data, formula = subject + activity ~ variable, mean)
write.table(final.data, "final_data.txt") # this is the final output
