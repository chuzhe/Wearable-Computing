Wearable-Computing
==================

##Project for Getting and Cleaning Data in Coursera

This repo implement the course project in Getting and Cleaning Data in Coursera. 

Please refer to the data folder for the raw data used in this repo. Wearable computing data is used in this repo. You can download the data in this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. For more information, please refer to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

run_analysis.R contains codes for this project. In particular, it does the following:
1. downloading and unziping data
2. merge training and testing data
3. extract measurements related to mean and standard deviation.
4. attach label to each activity in the dataset, for example 1 is walking
5. assignment appropriate column name to the complete data
6. create a new dataset. This dataset take the average of each variables for each activity and each subject
7. output the dataset to a new file

Please see CoodBook.md for a detailed explanation of the raw data and output.

