Getting and Cleaning Data - Course Project
Iulia Stefan

Project Goals:
The goal of this project is to demonstrate how to collect, work with, and clean a data set using R. The outcome of the 
accompanying R script is a tidy data set that can be used for later analysis. See section 3 for a description of the dataset.

Document Purpose:
This document describes the dataset used in the project and how to run the accompanying R script ('run_analysis.R') to transform the data.

Data Overview:
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data we will be working with for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. This dataset contains data on test and training subjects -- subjects' activities were tracked using the smartphone, and readings from the smartphone (X-vars) were compared to actual activities like walking, sitting, standing, etc. (Y-vars).

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data can be found here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Running the R script:
This script downloads, merges, tidies up and aggregates the data from the UCI Har Dataset mentioned above. Specifically, it:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script:
- Download the data from the link above and move it to the location where you want to save it
- Download and save the script in the same directory where you saved the data
- Open the script and update line 16 to the location where you saved the data and script
- Save the script
- Open R studio; go to File > Open and browse for the script
- The script should load; click on 'Source' on the top right to execute the script
- Note that the output file ('tidy_data.txt') will save to the same location as the script
