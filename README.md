---
title: "README.md"
author: "Asad Ali Shah"
date: "4/16/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Getting & Cleaning Data Project

### Step-1: Mergeing the training and the test sets to create one data set.

```{r}
courseFile <- "gacdassignment.zip" #getting and clearning data assignment

# Checking if the file exists or not and if not downloading it
if(!file.exists(courseFile)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, courseFile)
}

# Creating a folder and unzipping the files
if (!file.exists("UCI Dataset")) { 
    unzip(courseFile) 
}
```
Next, we read all the relevant data and assign it to data.frames using `read.table()` from *readr* package.

```{r}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
```

Than, we go on to combine all the data.frames to create a single data set in two steps:

```{r}
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
allData <- cbind(subject, x, y)
```

### Step-2: Extracting the measurements on the mean and standard deviation for each measurement

In this step, all the measurements that contian mean or standard deviation are extracted into a new data frame.

```{r}
library(dplyr)
finalData <- allData %>% select(subject, code, contains("mean"), contains("std"))
```

### Step-3: Giving descriptive names to activities in the data set

Remember, there are 6 activities as follows: 

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

Currently, the data set contains numbers which are replaced with the activity i.e., WALKING, WALKING_UPSTAIRS, etc. with the following code.


```{r}
finalData$code <- activities[finalData$code, 2]
```

### Step - 4: Appropriately labels the data set with descriptive variable names.

Here, descriptive names are assigned to each variable.

```{r}
names(finalData)[2] = "activity"
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
```

### Step - 5: Create an independent tidy data set with the average of each variable for each activity and each subject.

```{r}
finalOutput <- finalData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(finalOutput, "finalOutput.txt", row.name=FALSE)
```

Reading the new data set in a data frame to ensure that it is delivering the right output.

```{r}
temp <- read.table("finalOutput.txt", header = T)
View(temp)
```