This is the codebook for the Getting and Cleaning data Course

## Download the dataset
[The dataset UCI HAR was downloaded via this url](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Extracting the data from the files
For more infomation about the .txt files please read the README file in the "UCI HAR Dataset" directory
- features <- features.txt : 561 rows, 2 columns
- activity_labels <- activity_labels.txt : 6 rows, 2 columns
### Test files
- subject_test <- test/subject_test.txt : 2947 rows, 1 column
- x_test <- test/X_test.txt : 2947 rows, 561 columns
- y_test <- test/y_test.txt : 2947 rows, 1 columns
### Train files
- subject_train <- test/subject_train.txt : 7352 rows, 1 column
- x_train <- test/X_train.txt : 7352 rows, 561 columns
- y_train <- test/y_train.txt : 7352 rows, 1 columns

## Merging the training and testing data
- x : 10299 rows, 561 columns by merging x_test and x_train 
- y : 10299 rows, 1 column by merging y_test and y_train
- subjects : 10299 rows, 1 column by merging subject_test and subject_train
- har_data : 10299 rows, 563 column by merging subjects, x and y

## Extracts only the measurements on the mean and standard deviation for each measurement
har_mean_sd : 10299 rows, 88 columns is a subset of har_data

## Uses descriptive activity names to name the activities in the data set
Here we label the data set with descriptive variable names  
- All start with character f replaced by Frequency
- All start with character t replaced by Time 
- Acc replaced by Accelerometer
- Gyro replaced by Gyroscope
- BodyBody replaced by Body
- Mag in column’s name replaced by Magnitude

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- har_means : 180 rows, 88 columns by taking the means of each variable for each activity and each subject, after groupped by subject and activity.
- Exportted har_means into clean_har_dataset.txt.