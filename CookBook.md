CoodBook
==================

This file give a broad overview of the raw data, the code used to process them and the output.

## Raw Data
Please refer to the data folder for the raw data used in this repo. You can download the data in this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. For more information, please refer to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original dataset is divided into two part: training data and testing data. The structure is the same for both training and testing data. There are no column heading for all file, so some explanation is in order. The subject file (subject_train.txt and subject_test.txt) tell us the data belong to which subject. There are a total of 30 subjects. the y file (y_train.txt and y_test.txt) tell us what is the subject's activity when the data is recorded. Only the activity ID is recorded. There are 6 possible activities, please refer to activity_labels.txt for the details in activity. The x file (x_train.txt and x_test.txt) is the main data file. It have a total of 561 columns. Each column correspond to a feature. For more information on the feature available, please refer to feature_info.txt. For a full list of feature, please refer to feature.txt.

## R Code
run_analysis.R contains codes for this project. In particular, it does the following:

1. downloading and unziping data
2. merge training and testing data
3. extract measurements related to mean and standard deviation.
4. attach label to each activity in the dataset, for example 1 is walking
5. assignment appropriate column name to the complete data
6. create a new dataset. This dataset take the average of each variables for each activity and each subject
7. output the dataset to a new file

Please refer to the comments in the code for technical details.

## Output Data
Please see either tidy.txt or tidy.csv for the tidy data asked for in the project. These two file contain the same data but in different format. Use `tidy <- read.table("tidy.txt")` to read the file into R.

The first three columns in the tidy data contians activityID, SubjectID and activity name. All remaining columns are the mean of the measurement. Unit is the same as the original file. Each column is labeled using names in feature.txt. Since R does not allow "()" and "-" in column name, I eliminated "()" and replaced "-" with ".". For example, tBodyAcc-mean()-X becomes tBodyAcc.mean.X. 

Since the assignment ask for only "mean and standard deviation for each measurement", I included only features that contain either "mean()" or "std()" in its name. In total, there are 66 measurements (out of 561) and therefore 66 such columns.

In conclusion, the tidy data set contains the mean of all measurement related to mean and standard deviation for each activity and each subject.