library(dplyr)

# Verify that file doesn't exists

if(!file.exists("dataset_project3.zip")){
  
  #Downloading the .zip containing the dataset
  
  file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(file_url, "dataset_project3.zip", method = "curl")
  
  # Unzipping the file
  
  unzip("dataset_project3.zip")
  date_downloaded <- date()
}

# Note: Remember that the file will download in your current work directory


#Loading the data 

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("feature_id", "functions"))

# "Test" data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[["functions"]])
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")

# "Train" data

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[["functions"]])
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")

# Merging the datasets

x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)

subjects <- rbind(subject_test, subject_train)
har_data <- cbind(subjects, x, y) #I named "har" for HAR


# Extraction of measuremnts on the mean and sd for each measurement

har_mean_sd <- select(har_data, subject, code, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set

har_mean_sd[["label"]] <- activity_labels[har_mean_sd[["label"]], 2]

# Appropriately labels the data set with descriptive variable names.

names(har_mean_sd)<-gsub("Acc", "Accelerometer", names(har_mean_sd))
names(har_mean_sd)<-gsub("angle", "Angle", names(har_mean_sd))
names(har_mean_sd)<-gsub("BodyBody", "Body", names(har_mean_sd))
names(har_mean_sd)<-gsub("^f", "Frequency", names(har_mean_sd))
names(har_mean_sd)<-gsub("Gyro", "Gyroscope", names(har_mean_sd))
names(har_mean_sd)<-gsub("gravity", "Gravity", names(har_mean_sd))
names(har_mean_sd)<-gsub("Mag", "Magnitude", names(har_mean_sd))
names(har_mean_sd)<-gsub("^t", "Time", names(har_mean_sd))
names(har_mean_sd)<-gsub("tBody", "TimeBody", names(har_mean_sd))
names(har_mean_sd)<-gsub("-mean", "Mean", names(har_mean_sd), ignore.case = TRUE)
names(har_mean_sd)<-gsub("-std", "STD", names(har_mean_sd), ignore.case = TRUE)
names(har_mean_sd)<-gsub("-freq()", "Frequency", names(har_mean_sd), ignore.case = TRUE)

# From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.

har_means <- group_by(har_mean_sd, subject, code) %>% summarise_all(list(mean))

write.table(har_means, "clean_har_dataset.txt", row.name=FALSE)

View(har_means)




