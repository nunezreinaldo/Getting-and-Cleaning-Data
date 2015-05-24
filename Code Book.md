# Getting and Cleaning Data (Coursera). Course Project Codebook

##Data Collection

Raw data are obtained from the main URL were all the data will be download: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Source
**Human Activity Recognition Using Smartphones Dataset**
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


## Raw Data Sets

The raw data sets are processed with the script run_analysis.R script to create a tidy data set.

Merge training and test sets Test and training data, subject ids and activity ids are merged to obtain a single data set. 

Variables are labelled with the names assigned by original collectors.

Extract mean and standard deviation variables Keep only the values of estimated mean and standard deviation .

Get descriptive activity names A new column is added to intermediate data set with the activity description.

Get abel variables appropriately Labels given from the original collectors were changed to get valid/more descriptive R names

Create a tidy data set From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject.



### Raw data set transformation

One of the transformation occured was at the variable level where using descriptive activity names  (loaded from "activity_labels.txt")to name the activities in the data set. It's is now each person/subject performed six activities (**WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING**); however the cource dataset got a numeric representation of the activities.   We transformed the data to include the description. The header/variable name of this item was also transformed to include  "activity".

The header/field name V1 - was change in the target Tidy data set to state the identifier of the subject who carried out the experiment. We used "subject" instead of V1

The raw dataset was created using the following regular expression to filter out required features, eg. the measurements on the mean and standard deviation for each measurement from the original feature vector set -(mean|std) using scape charaters

The header/field name of the final Tidy Dataset were change to make those more Human readable, as follow:

* String () was replaced by empty/blank.
* Prefix t was replaced by word "time-".
* Prefix f was replaced by word "frequency-".
* String Acc was replaced by word "Accelerometer".
* String Gyro was replaced by word "Gyroscope".
* String Mag was replaced by word "Magnitude".
* String BodyBody was replaced by word "Body".

All those changes were executed based in the content of a file named:  features_info located in the directory \data\UCI HAR Dataset\ 

|** Raw data**	| **Tidy data**| 
| label		| New label| 
| tGravityAcc-std()-X	|time-GravityAccelerometer-std-X| 
| tGravityAcc-std()-Y	|time-GravityAccelerometer-std-Y|         
| tGravityAcc-mean()-Z	|time-GravityAccelerometer-mean-Z|  
| tBodyGyroJerkMag-std()|time-BodyGyroscopeJerkMagnitude-std| 
| fBodyAcc-mean()-X	|frequency-BodyAccelerometer-mean-X|           
| fBodyAcc-mean()-Y	|frequency-BodyAccelerometer-mean-Y| 