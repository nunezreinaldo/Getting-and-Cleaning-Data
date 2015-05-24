### Introduction

This assignment for Getting and Cleaning Data Course Project will require me to write an R script that to demonstrate the ability to collect, work with, and clean a data set. 

The goal is to prepare tidy data that can be used for later analysis. I should submit
First : a tidy data set as described below, 
Second: a link to a Github repository with your script for performing the analysis, 
Third : a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 


The main URL were all the data will be download is: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



The R script got an identification area, followed by a brief list of requirements in this assigment
A series of preliminar steps (from A to D) are detailed. Those preliminar steps are steps needed to reproduce the script in a future date without 
executing manual steps out of the scripts. Those are not required by the activity, but I decided to included within the script.
Steps 1 to 5 as requested by the assigment are detailed with inital comments before each step.
Extra step: A final extra step is included at the end to create a file with the output file created in step 4

 RNunez
 May 23 2015
 Project Assigment
 You should create one R script called run_analysis.R that does the following:
 1 - Merges the training and the test sets to create one data set.
 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
 3 - Uses descriptive activity names to name the activities in the data set
 4 - Appropriately labels the data set with descriptive variable names. 
 5 - From the data set in step 4, creates a second, independent tidy data set with 
 the average of each variable for each activity and each subject.

###  Preliminar steps: 
 Not sure if all the preliminary steps need to be build inside the R script
 neither if all those relimianry steps will be evaluate; however I'm setting all those steps
 here in order to reproduce the script in future dates

###  Preliminar step A. - Download the file and put the file in the data folder

### Preliminar step B. - Unzip the file
    unzip from  library(utils)

### Preliminar step C. - Read the Readme file located on data\UCI HAR Dataset

### Preliminar step D. 
 Set the path to read all the files then read all files to be used
 Not sure what good name to give toe ach file; I settle 
 for the almost default file name.

 -------------------------------------------------------
### Assigments Steps
 -------------------------------------------------------
1. Merges the training and the test sets to create one data set.                             
 At this point NOT sure how each merge would be used at this point.
 xtrain and xtest needs to be merge together (append) since got the same number of variables with the same type and name
 ytrain and ytest needs to be merge together (append) since both files got an unique variable with the same type and name
 subjecttrain and subjecttest needs to be merge together (append) since both files got an unique variable with the same type and name
 xall, yall and subjectall will be merge together by column since they got all the same number of records
 ------------------------------------------------------
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 My understanding of this item is to extract/display or create a subset with those measurement columns
 that got name related to the mean and standard deviation.
 features variable (dataset coming from features.txt file) contain column names and features$V2 is the column with all Field Names.
 Beolow, we will select the Indexes (row number) for only the columns which field names contain either “mean()” or “std()” on it.
 grep if from base library
------------------------------------------------------------------------------------------
 Select from features.txt only those fields that got the text MEAN  or STD on the names
 If other field got values representing MEANS or STD and are name diferently, will be ignore
 subset specific columns from xall (subset with measures)
 Set the real field (column) names for xall
 need to recreate all data since the contain of Xall changed

3.Uses descriptive activity names to name the activities in the data set
 Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)   
 That description comes from activities <- read.table("activity_labels.txt"); already executed above

 update values with correct activity names
 reset field/header name
 need to recreate all data since the contain of yall changed

4. Appropriately labels the data set with descriptive variable names. 
  In the directory \data\UCI HAR Dataset\ there is a file named: features_info which talks a little bite more
  each filed/header name. This is used as a clue to re-label the fields/headers using descriptive names.
  Arbitrarily decided to change every hfields/headers to:

  Convert it to LOWER CASE
  prefix t is replaced by word "time"
  prefix f is replaced by word "frequency"
  prefix () is replaced by empty/blank

  Word Acc is replaced by word "Accelerometer"
  Word Gyro is replaced by word "Gyroscope"
  Word Mag is replaced by word "Magnitude"
  Word BodyBody is replaced by word "Body"
 ------------------------------------------------------------------------
 Fix header/filed name V1 - An identifier of the subject who carried out the experiment.
 need to recreate all data since the contain of subjectall changed
 Pattern changes

5. From the data set in step 4 (prior step), creates a second, independent tidy data set 
 with the average of each variable for each activity and each subject.
 Found out this can also be possible using ddply fron library(plyr) as displayed 
 in lectures, but decided to use aggregate since I like it more from # library(stats)
 summarize data

### Extra step:
 Create txt file with write.table() using row.name=FALSE
 for the tidy data set created in step 5 of the instructions. 
 write file to output
