---
title: "Code book"
author: "Asad Ali Shah"
date: "4/16/2020"
output: html_document
---

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

Using *gsub()* function, adding descriptive words to variable names to make them more readable.
- All variable names starting with `t` replaced with `Time` 
- All variables names starting with `f` replaced with `Frequency`
- `Acc` in variable names replaced with `Accelerometer`
- `Gyro` in variable names replaced with `Gyroscope`
- `BodyBody` in variable names replaced with `Body` 
- `Mag` in variable names replaced with `Magnitude` 

All the variable names are reproduced after the next step.


## Step 5
`finalOutput.txt` is created taking the means of each variable for each activity and each subject, after groupped by subject and activity. It is written into `finalOutput.txt` dataset using *write.table()*. This dataset is read back into using using *read.table()* function into a `temp` data frame which is viewed using `View(temp)`.



## Descriptive Variable Names

- "x"
- "subject"
- "activity"
- "TimeBodyAccelerometer.Mean...X"
- "TimeBodyAccelerometer.Mean...Y"
- "TimeBodyAccelerometer.Mean...Z"
- "TimeGravityAccelerometer.Mean...X"
- "TimeGravityAccelerometer.Mean...Y"
- "TimeGravityAccelerometer.Mean...Z"
- "TimeBodyAccelerometerJerk.Mean...X"
- "TimeBodyAccelerometerJerk.Mean...Y"
- "TimeBodyAccelerometerJerk.Mean...Z"
- "TimeBodyGyroscope.Mean...X"
- "TimeBodyGyroscope.Mean...Y"
- "TimeBodyGyroscope.Mean...Z"
- "TimeBodyGyroscopeJerk.Mean...X"
- "TimeBodyGyroscopeJerk.Mean...Y"
- "TimeBodyGyroscopeJerk.Mean...Z"
- "TimeBodyAccelerometerMagnitude.Mean.."
- "TimeGravityAccelerometerMagnitude.Mean.."
- "TimeBodyAccelerometerJerkMagnitude.Mean.."
- "TimeBodyGyroscopeMagnitude.Mean.."
- "TimeBodyGyroscopeJerkMagnitude.Mean.."
- "FrequencyBodyAccelerometer.Mean...X"
- "FrequencyBodyAccelerometer.Mean...Y"
- "FrequencyBodyAccelerometer.Mean...Z"
- "FrequencyBodyAccelerometer.MeanFreq...X"
- "FrequencyBodyAccelerometer.MeanFreq...Y"
- "FrequencyBodyAccelerometer.MeanFreq...Z"
- "FrequencyBodyAccelerometerJerk.Mean...X"
- "FrequencyBodyAccelerometerJerk.Mean...Y"
- "FrequencyBodyAccelerometerJerk.Mean...Z"
- "FrequencyBodyAccelerometerJerk.MeanFreq...X"
- "FrequencyBodyAccelerometerJerk.MeanFreq...Y"
- "FrequencyBodyAccelerometerJerk.MeanFreq...Z"
- "FrequencyBodyGyroscope.Mean...X"
- "FrequencyBodyGyroscope.Mean...Y"
- "FrequencyBodyGyroscope.Mean...Z"
- "FrequencyBodyGyroscope.MeanFreq...X"
- "FrequencyBodyGyroscope.MeanFreq...Y"
- "FrequencyBodyGyroscope.MeanFreq...Z"
- "FrequencyBodyAccelerometerMagnitude.Mean.."
- "FrequencyBodyAccelerometerMagnitude.MeanFreq.."
- "FrequencyBodyAccelerometerJerkMagnitude.Mean.."
- "FrequencyBodyAccelerometerJerkMagnitude.MeanFreq.."
- "FrequencyBodyGyroscopeMagnitude.Mean.."
- "FrequencyBodyGyroscopeMagnitude.MeanFreq.."
- "FrequencyBodyGyroscopeJerkMagnitude.Mean.."
- "FrequencyBodyGyroscopeJerkMagnitude.MeanFreq.."
- "Angle.TimeBodyAccelerometerMean.Gravity."
- "Angle.TimeBodyAccelerometerJerkMean..GravityMean."
- "Angle.TimeBodyGyroscopeMean.GravityMean."
- "Angle.TimeBodyGyroscopeJerkMean.GravityMean."
- "Angle.X.GravityMean."
- "Angle.Y.GravityMean."
- "Angle.Z.GravityMean."
- "TimeBodyAccelerometer.STD...X"
- "TimeBodyAccelerometer.STD...Y"
- "TimeBodyAccelerometer.STD...Z"
- "TimeGravityAccelerometer.STD...X"
- "TimeGravityAccelerometer.STD...Y"
- "TimeGravityAccelerometer.STD...Z"
- "TimeBodyAccelerometerJerk.STD...X"
- "TimeBodyAccelerometerJerk.STD...Y"
- "TimeBodyAccelerometerJerk.STD...Z"
- "TimeBodyGyroscope.STD...X"
- "TimeBodyGyroscope.STD...Y"
- "TimeBodyGyroscope.STD...Z"
- "TimeBodyGyroscopeJerk.STD...X"
- "TimeBodyGyroscopeJerk.STD...Y"
- "TimeBodyGyroscopeJerk.STD...Z"
- "TimeBodyAccelerometerMagnitude.STD.."
- "TimeGravityAccelerometerMagnitude.STD.."
- "TimeBodyAccelerometerJerkMagnitude.STD.."
- "TimeBodyGyroscopeMagnitude.STD.."
- "TimeBodyGyroscopeJerkMagnitude.STD.."
- "FrequencyBodyAccelerometer.STD...X"
- "FrequencyBodyAccelerometer.STD...Y"
- "FrequencyBodyAccelerometer.STD...Z"
- "FrequencyBodyAccelerometerJerk.STD...X"
- "FrequencyBodyAccelerometerJerk.STD...Y"
- "FrequencyBodyAccelerometerJerk.STD...Z"
- "FrequencyBodyGyroscope.STD...X"
- "FrequencyBodyGyroscope.STD...Y"
- "FrequencyBodyGyroscope.STD...Z"
- "FrequencyBodyAccelerometerMagnitude.STD.."
- "FrequencyBodyAccelerometerJerkMagnitude.STD.."
- "FrequencyBodyGyroscopeMagnitude.STD.."
- "FrequencyBodyGyroscopeJerkMagnitude.STD.."