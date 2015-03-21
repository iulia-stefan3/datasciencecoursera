Getting and Cleaning Data - Course Project
Iulia Stefan

1. Project Goals
The goal of this project is to demonstrate how to collect, work with, and clean a data set using R. The outcome of the 
accompanying R script is a tidy data set that can be used for later analysis. See section 3 for a description of the dataset.

2. Document Purpose
This document describes the raw data and all transformations performed to it using the 'run_analysis.R' script.

3. Data Overview
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data we will be working with for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. This dataset contains data on test and training subjects -- subjects' activities were tracked using the smartphone, and readings from the smartphone (X-vars) were compared to actual activities like walking, sitting, standing, etc. (Y-vars).

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data can be found here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

4. Attribute Information:
For each record in the dataset, the following information is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

5. Transformations Performed to the Raw Data:
The accompanying R script ('run_analysis.R') downloads, merges, tidies up and aggregates the data from the UCI Har Dataset mentioned above. Specifically, it:

1. Merges the training and the test sets to create one data set.
- Reads in the features, activity and subject data for the TEST group
- Reads in the features, activity and subject data for the TRAIN group
- Merges each of the 3 TEST and TRAIN datasets together
- Reads in the header names for the features_TRAIN & features_TEST datasets & store as variable
- Gives column names to each of the merged 3 datasets
- Merges the subject_data, activity_data & features_data into 1 dataset. Note that this assumes the data in each file is lined up correctly such that the cbind produces the correct results. If the data got out of order in one of the files for example, when doing the cbind you'd have the subject's id associated with someone else's activity and features.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- Extracts the column index of subject & activity, plus all columns that have mean or standard deviation in the column header
- Extracts subset of data based on column indices from previous step

3. Uses descriptive activity names to name the activities in the data set
- Reads in the activity details corresponding to each activityId in the final_data & store as variable
- Names the columns in activity_Details
- Merges the final_data set with the acitivity_Details on activityId, to include activityName in the final_data as separate column

4. Appropriately labels the data set with descriptive variable names.
- Looks at the column names of the final_data
- Makes the replacements based on examining the names in the previous step

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Removes activityName temporarily
- Calculates the mean of each variable (other than activityId & subjectId) for each activity and subject
- Merges activityName back
- Exports the tidy_data to file in same working directory