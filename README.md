### Introduction

This project contains an R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Example: Producing a tidy dataset

After sourcing run_analysis.R please execute the following in an environment where the extracted Samsung data exists and the “UCI HAR Dataset” directory has been created:

produceTidyDataset()

As a result a file named “theFinalSummary.txt” will be created in your working directory.

Enjoy!

