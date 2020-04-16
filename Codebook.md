---
title: "Code book"
author: "Asad Ali Shah"
date: "4/16/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The `run_analysis.R` script follows 5 steps described in the *Instructions* section of the *Getting and Cleaning Data Course Project*. Some steps have multiple sub-steps. 

## Step - 1
1.1. Data is downloaded into a folder called UCI HAR Dataset.
1.2. Folder is unzipped and files are extracted into the same folder.
1.3. Different files are read and assigned into different data frames.
- `features` <- `features.txt`. Each row     corresponds to a variable in the main datasets.
- `activities` <- `activity_labels.txt`. Each row corresponds to one activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
- `subject_test` <- `test/subject_test.txt`. Test data available the test folder.
- `x_test` <- `test/X_test.txt` contains recorded features test data. Available the test folder.
- `y_test` <- `test/y_test.txt` contains test data of activities’code labels. Available the test folder.
- `subject_train` <- `test/subject_train.txt`. Train data available in the train folder.
-`x_train` <- `test/X_train.txt` contains recorded features train data. Available in the train folder.
- `y_train` <- `test/y_train.txt` contains train data of activities’code labels. Available in the train folder.

1.4. Merge the test and training data into one data frame.
- `x-test` and `x-train` data sets are merged using *rbind()* function in a new dataframe `x`
- `y-test` and `y-train` data sets are merged using *rbind()* function in a new dataframe `y`
- `subject` is created by combining `subject_test` and `subject_train` also using *rbind()* function
- `allData` is created by merging `x`, `y` and `subject` using *cbind()* function.
    

## Step - 2 
A new tidy dataframe `finalData` is created by selecting the columns (variables) which contain the `mean` or `std` (e.g., standard deviations) measurements. Note that we have used the *select()* function of *deply* package for selection.


## Step - 3
In the `finalData`, the entries of the `code` variable are replaced with their descriptive activity names.

## Step - 4
In the `finalData`, the variables are name descriptively.
- `code` is renamed `activity`

Using *gsub()* function, adding descriptive words to variable names.
- `Acc` in variable names replaced with `Accelerometer`
- `Gyro` in variable names replaced with `Gyroscope`
- `BodyBody` in variable names replaced with `Body` 
- `Mag` in variable names replaced with `Magnitude` 
- All variable names starting with `t` replaced with `Time` 
- All variables names starting with `f` replaced with `Frequency`

## Step 5
`finalOutput.txt` is created taking the means of each variable for each activity and each subject, after groupped by subject and activity. It is written into `finalOutput.txt` dataset using *write.table()*. This dataset is read back into using using *read.table()* function into a `temp` data frame which is viewed using `View(temp)`.