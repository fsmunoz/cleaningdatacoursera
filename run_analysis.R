### Coursera - Getting and Cleaning Data
### Course Project
###
### 2014, Frederico Munoz <fsmunoz@gmail.com>
###
### Here are the data for the project:
### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###  You should create one R script called run_analysis.R that does the following. 
###  - Merges the training and the test sets to create one data set.
###  - Extracts only the measurements on the mean and standard deviation for each measurement. 
###  - Uses descriptive activity names to name the activities in the data set
###  - Appropriately labels the data set with descriptive activity names. 
###  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###
### This file is thoroughly commented (excessively so) given the
### pedagogic nature of it. All output is written as CSV files since
### it is easier to inspect and work with from multiplace
### applications.

library(reshape2) # used for melt/dcast

### Global variables use throughout
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetFile <- "UCI HAR Dataset.zip"
datasetDir <-  "UCI HAR Dataset"

### Check for zipped dataset file: if it doesn't exist then download it
if (!file.exists(datasetFile) && !file.exists(datasetDir)) {
    download.file(fileUrl, destfile=datasetFile, method="curl")
} else {
    print("File already exists, skipping download")
}

### Check for dataset directory, and unzip file if it doesn't exist
if(!file.exists(datasetDir)) {
    unzip(zipfile = datasetFile)
} else  {
    print("Dataset directory already exists, skipping unzip")
}

### Import datasets and merge them
X.traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
X.testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
X.data <- rbind(X.testdata, X.traindata) # merge
Y.traindata <- read.table("./UCI HAR Dataset/train/y_train.txt")
Y.testdata <- read.table("./UCI HAR Dataset/test/y_test.txt")
Y.data <- rbind(Y.testdata, Y.traindata) # merge

### Read and merge subjects
sub.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
sub.data <- rbind(sub.train, sub.test) # merge

### Import the features and activities
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
## This transforms WALKING_UPSTAIRS > "WALKING_UPSTAIRS" >
## "walking_upstairs" > "walkingupstairs"
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))

### Add labels; this will change Y.data:
### 
###   V1  >     activity >     activity
### 1  5  >   1 5        >   1  standing
### 2  5  >   2 5        >   2  standing
### 3  5  >   3 5        >   3  standing
###
names(Y.data) <- "activity" # changes col name from "V1" to something meaningful
Y.data [,1] = activities[Y.data[,1], 2] # this replaces "1" with "walking", etc.

### Extract mean and SD only; there are plenty of measurements but the
### mean and SD always end in "-mean()" and "-std()", e.g.:
### > features
### [...]
### 503 503                   fBodyAccMag-mean()  <--- the mean
### 504 504                    fBodyAccMag-std()  <--- the SD
### 505 505                    fBodyAccMag-mad()
### 506 506                    fBodyAccMag-max()
###
### NB: there is a decision here: mean and SD are taken from fields
### which end in -mean() and -std(); this is important since there are
### other fields which include words like "Avg" in their name and that
### could be also included. I have opted to keep them out and use only
### the ones that follow the rule above since these are the ones which
### are explicitly marked as means and SDs.
###
### Use grep to match for these fields and then store them into a new
### variable
meanSD.features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) # match
X.data.meanSD<-X.data[,meanSD.features]                          # store
## same approach as before but deleting the "()"
names(X.data.meanSD)<-tolower(gsub("\\(|\\)", "", features[meanSD.features, 2])) 

## After this last step we have 66 variable, all of them related to
## mean and SD, in our new variable:
## > str(X.data.meanSD)
## 'data.frame':	10299 obs. of  66 variables:
##  $ tbodyacc-mean-x          : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ tbodyacc-mean-y          : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ tbodyacc-mean-z          : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
##  $ tbodyacc-std-x           : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
##  $ tbodyacc-std-y           : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
##  $ tbodyacc-std-z           : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
##  $ tgravityacc-mean-x       : num  0.936 0.927 0.93 0.929 0.927 ...
##  [...]

### Final arragements, merging and saving of dataset
###
### tmp.dataset will be a "long" table, with all the mean values in
### X.data.meanSD prepended with one column indicating the activity
### and another one the subject:
###
###                    |-------------- from X.data.meanSD -----------|
###   subject activity tbodyacc-mean-x tbodyacc-mean-y tbodyacc-mean-z
### 1       1 standing       0.2571778     -0.02328523     -0.01465376
### [...]
###

names(sub.data) <- "subject"  # label the column
tmp.dataset <- cbind(sub.data, Y.data, X.data.meanSD) # bind all the columns
write.csv(tmp.dataset, "temp_data.csv", row.names = FALSE) # write it to disk, as CSV file.

### Creates a second, independent tidy data set with the average of
### each variable for each activity and each subject.
###
### This will be done using melt/cast, thus reshaping the data: first
### by melting it (and making it into a "long-format" table) using
### activity and subject as ids, then by recasting it but this time
### calculating the average of each variable by the same ids.

## Melt the data using subject and activity as id:
melted.data <- melt(tmp.dataset, id=c("subject","activity"))

## This produces a long format table:
##
## > head(melted.data)
##   subject activity        variable     value
## 1       1 standing tbodyacc-mean-x 0.2571778
## 2       1 standing tbodyacc-mean-x 0.2860267
## 3       1 standing tbodyacc-mean-x 0.2754848
##
## ... which has less columns but more rows:
## > str(tmp.dataset)
## 'data.frame':	10299 obs. of  68 variables:
## [...]
## > str(melted.data)
## 'data.frame':	679734 obs. of  4 variables:
## [...]

## Cast the melted table, but calculating the mean of the "variable"
## column (which contains all the variable names as factors) and 
final.data <- dcast(melted.data, formula = subject + activity ~ variable, mean)


## Some real magic using melt/dcast of the reshape2 library, which
## creates the final data. melt takes wide-data and melts it into
## long-format data, and castthe opposite (dcast is for data frames)
melted.data <- melt(tmp.dataset, id=c("subject","activity"))
final.data <- dcast(melted.data, formula = subject + activity ~ variable, mean)
write.csv(final.data, "final_data.csv", row.names = FALSE) # this is the final output, as a CSV file

## The final, tidy dataset has 180 observations and 68 variables; the
## numering variables are now the mean value for each one of them for
## each combination of subject + activity; all columns are named and
## all factors are explicitly labelled.
##
## str(final.data)
## 'data.frame':	180 obs. of  68 variables:
##  $ subject                  : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ activity                 : chr  "laying" "sitting" "standing" "walking" ...
##  $ tbodyacc-mean-x          : num  0.281 0.276 0.278 0.276 0.278 ...
##  $ tbodyacc-mean-y          : num  -0.0182 -0.0131 -0.0173 -0.0186 -0.0227 ...
##  [...]
##
## The dataset is wide (again) and so the excerpt below is clipped horizontally as well:
##
## head(final.data)
##   subject          activity tbodyacc-mean-x tbodyacc-mean-y tbodyacc-mean-z
## 1       1            laying       0.2813734     -0.01815874      -0.1072456
## 2       1           sitting       0.2759908     -0.01305597      -0.1098725
## 3       1          standing       0.2776850     -0.01732705      -0.1035844
## [...]

## EOF
