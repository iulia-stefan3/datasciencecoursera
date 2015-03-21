# Getting and Cleaning Data - Course Project
# Iulia Stefan

# This script downloads, merges, tidies up and aggregates data from the UCI Har Dataset.
# This dataset contains data on test and training subjects in the area of wearable computing. 
# Subjects' activities were tracked using a Samsung smartphone, and readings from the smartphone (X-vars)
# were compared to actual activities like walking, sitting, standing, etc. (Y-vars).
# Additional details are available in the README.md and CodeBook.md files included in the repo.



# 1. Merge the training and the test sets to create one data set.

  # Clear workspace and get current working directory
  rm(list=ls())
  getwd()
  
  # Set working directory to the location of the data
  setwd('/Users/istefan/Documents/Iulia/Coursera/Getting & Cleaning Data/UCI HAR Dataset')

  # Read in the features, activity and subject data for the TEST group
  subject_TEST <- read.table('./test/subject_test.txt', header = FALSE)
  activity_TEST <- read.table('./test/y_test.txt', header = FALSE)
  features_TEST <- read.table('./test/X_test.txt', header = FALSE)

  # Read in the features, activity and subject data for the TRAIN group
  subject_TRAIN <- read.table('./train/subject_train.txt', header = FALSE)
  activity_TRAIN <- read.table('./train/y_train.txt', header = FALSE)
  features_TRAIN <- read.table('./train/X_train.txt', header = FALSE)

  # Merge each of the 3 TEST and TRAIN datasets together
  subject_data <- rbind(subject_TEST, subject_TRAIN)
  activity_data <- rbind(activity_TEST, activity_TRAIN)
  features_data <- rbind(features_TEST, features_TRAIN)

  # Read in the header names for the features_TRAIN & features_TEST datasets & store as variable
  feature_Names <- read.table('./features.txt')

  # Give column names to each of the merged 3 datasets
  colnames(subject_data) <- "subjectId"
  colnames(activity_data) <- "activityId"
  colnames(features_data) <- feature_Names[,2]

  # Merge the subject_data, activity_data & features_data into 1 dataset. 
  # Note that this assumes the data in each file is lined up correctly such that the cbind produces the correct results.
  # If the data got out of order in one of the files for example, when doing the cbind you'd have the subject's id
  # associated with someone else's activity and features.
  merged_data <- cbind(subject_data, activity_data, features_data)



# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

  # Extract the column index of subject & activity, plus all columns that have mean or standard deviation in the column header (from feature_Names)
  mean_STD_cols <- grep(".*mean.*|.*std.*|subjectId|activityId", names(merged_data), ignore.case=TRUE)

  # Extract subset of data based on column indices from previous step
  final_data <- merged_data[,mean_STD_cols]  



# 3. Use descriptive activity names to name the activities in the data set.

  # Read in the activity details corresponding to each activityId in the final_data & store as variable
  activity_Details <- read.table('./activity_labels.txt')

  # Name the columns in activity_Details
  colnames(activity_Details) <- c("activityId", "activityName")

  # Merge the final_data set with the acitivity_Details on activityId, to include activityName in the final_data as separate column
  final_data <- merge(final_data, activity_Details, by = 'activityId')



# 4. Appropriately label the data set with descriptive activity names. 

  # Look at the column names of the final_data
  colnames(final_data)

  # Make the replacements based on examining the names in the previous step
  colnames(final_data) <- gsub("^t", "Time", colnames(final_data))
  colnames(final_data) <- gsub("^f", "Frequency", colnames(final_data))
  colnames(final_data) <- gsub("\\()","", colnames(final_data))
  colnames(final_data) <- gsub("Acc", "Acceleration", colnames(final_data))
  colnames(final_data) <- gsub("BodyBody", "Body", colnames(final_data))
  colnames(final_data) <- gsub("Gyro", "Gyroscope", colnames(final_data))
  colnames(final_data) <- gsub("Mag", "Magnitude", colnames(final_data))



# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  # Note I tried combining the first 3 steps below into 1, where I would just add the 'activityName' to the conditions in the aggregate command.
  # For some reason this did not work - I kept getting a repeat 'activityName' column at the very end of the file with all NAs

  # Remove activityName temporarily
  final_data_subset <- final_data[, colnames(final_data) != 'activityName']
  
  # Calculate the mean of each variable (other than activityId & subjectId) for each activity and subject
  tidy_data <- aggregate(final_data_subset[,names(final_data_subset) != c('activityId','subjectId')], by = list(activityId = final_data_subset$activityId, subjectId = final_data_subset$subjectId), mean)

  # Merge activityName back
  tidy_data <- merge(tidy_data, activity_Details, by = 'activityId')

  # Export the tidy_data to file in same working directory
  write.table(tidy_data, file = './tidy_data.txt', row.names = FALSE, col.names = TRUE, sep = '\t')
