# run_analysis file
# the file follows the steps required to produce the output
# from the UCI HAR Dataset

# Step 1

## download and unzip all files
getwd()
setwd("C:/Users/ashah/Documents/Data Science/gacd_repo")

## checking if archieve already exist
courseFile <- "gacdassignment.zip" #getting and clearning data assignment

if(!file.exists(courseFile)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, courseFile)
}

### checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(courseFile) 
}

## reading all data sets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## combine the rows and columns
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
allData <- cbind(subject, x, y)

# Step 2
# Extracting measurements containing mean and std

## final data
library(dplyr)
finalData <- allData %>% select(subject, code, contains("mean"), contains("std"))
head(finalData)

# Step 3
## Descriptive activity names in place of activity codes.
finalData$code <- activities[finalData$code, 2]

# Step 4
## Appropriately label the data set with descriptive variable names.
names(finalData)[2] <- "activity"
names(finalData)<-gsub("Acc", "Accelerometer", names(finalData))
names(finalData)<-gsub("Gyro", "Gyroscope", names(finalData))
names(finalData)<-gsub("BodyBody", "Body", names(finalData))
names(finalData)<-gsub("Mag", "Magnitude", names(finalData))
names(finalData)<-gsub("^t", "Time", names(finalData))
names(finalData)<-gsub("^f", "Frequency", names(finalData))
names(finalData)<-gsub("tBody", "TimeBody", names(finalData))
names(finalData)<-gsub("-mean()", "Mean", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-std()", "STD", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("-freq()", "Frequency", names(finalData), ignore.case = TRUE)
names(finalData)<-gsub("angle", "Angle", names(finalData))
names(finalData)<-gsub("gravity", "Gravity", names(finalData))
names(finalData)

# Step 5
## writing a new data set
finalOutput <- finalData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(finalOutput, "finalOutput.txt", row.name=FALSE)


## checking the new dataset by reading it into R
temp <- read.table("tidyData.txt", header = T)
View(temp)