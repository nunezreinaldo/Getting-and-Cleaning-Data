# RNunez
# May 23 2015
# Project Assigment
# You should create one R script called run_analysis.R that does the following:
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# Merges the training and the test sets to create one data set.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# -------------------------------------------------------
# Preliminar steps: Not sure if all the preliminary steps need to be build inside the R script
# neither if all those relimianry steps will be evaluate; however I'm setting all those steps
# here in order to reproduce the script in future dates
# -------------------------------------------------------
# Preliminar step A. - Download the file and put the file in the data folder
# ------------------------------------------------------

target_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
target_localfile = "./data/Dataset.zip"
if (!file.exists(target_localfile)) {
      download.file(target_url, target_localfile)
}

# -------------------------------------------------------
# Preliminar step B. - Unzip the file
# unzip from  library(utils)
# ------------------------------------------------------

unzip(target_localfile,exdir="./data")

# -------------------------------------------------------
# Preliminar step C. - Read the Readme file located on data\UCI HAR Dataset
# ------------------------------------------------------


# -------------------------------------------------------
# Preliminar step D. Set the path to read all the files
#                    then read all files to be used
# Not sure what good name to give toe ach file; I settle 
# for the almost default file name.
# ------------------------------------------------------
root_path <- "./data"
info_path <- "./data/UCI HAR Dataset"
train_path<- "./data/UCI HAR Dataset/train"
test_path <- "./data/UCI HAR Dataset/test"

features   <- read.table(file.path(info_path,"features.txt"))
activities <- read.table(file.path(info_path,"activity_labels.txt"))

subjecttrain <- read.table(file.path(train_path, "subject_train.txt"))
ytrain       <- read.table(file.path(train_path, "Y_train.txt"))
xtrain       <- read.table(file.path(train_path, "X_train.txt"))

subjecttest <- read.table(file.path(test_path, "subject_test.txt"))
ytest       <- read.table(file.path(test_path, "Y_test.txt"))
xtest       <- read.table(file.path(test_path, "X_test.txt"))
                                
# -------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.                             
# At this point NOT sure how each merge would be used at this point.
# xtrain and xtest needs to be merge together (append) since got the same number of variables with the same type and name
# ytrain and ytest needs to be merge together (append) since both files got an unique variable with the same type and name
# subjecttrain and subjecttest needs to be merge together (append) since both files got an unique variable with the same type and name
# xall, yall and subjectall will be merge together by column since they got all the same number of records
# ------------------------------------------------------

xall       <- rbind(xtrain, xtest)
yall       <- rbind(ytrain, ytest)
subjectall <- rbind(subjecttrain, subjecttest)
alldata    <- cbind(subjectall, yall, xall)

# -----------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# My understanding of this item is to extract/display or create a subset with those measurement columns
# that got name related to the mean and standard deviation.
# features variable (dataset coming from features.txt file) contain column names and features$V2 is the column with all Field Names.
# Beolow, we will select the Indexes (row number) for only the columns which field names contain either “mean()” or “std()” on it.
# grep if from base library
#------------------------------------------------------------------------------------------

# Select from features.txt only those fields that got the text MEAN  or STD on the names
# If other field got values representing MEANS or STD and are name diferently, will be ignore

selected_fields_mean_std<- grep("-(mean|std)\\(\\)", features[, 2])

# subset specific columns from xall (subset with measures)
xall        <- xall[, selected_fields_mean_std]

# Set the real field (column) names for xall
names(xall) <- features[selected_fields_mean_std, 2]

# need to recreate all data since the contain of Xall changed
alldata    <- cbind(subjectall, yall, xall)

# ------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)   
# That description comes from activities <- read.table("activity_labels.txt"); already executed above
# ------------------------------------------------------------------------

# update values with correct activity names
yall[, 1] <- activities[yall[, 1], 2]

# reset field/header name
names(yall) <- "activity"

# need to recreate all data since the contain of yall changed
alldata    <- cbind(subjectall, yall, xall)

# ------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names. 
#  In the directory \data\UCI HAR Dataset\ there is a file named: features_info which talks a little bite more
#  each filed/header name. This is used as a clue to re-label the fields/headers using descriptive names.
#  Arbitrarily decided to change every hfields/headers to:
#
#  prefix t is replaced by word "time"
#  prefix f is replaced by word "frequency"
#  prefix () is replaced by empty/blank

#  Word Acc is replaced by word "Accelerometer"
#  Word Gyro is replaced by word "Gyroscope"
#  Word Mag is replaced by word "Magnitude"
#  Word BodyBody is replaced by word "Body"
# ------------------------------------------------------------------------

# Fix header/filed name V1 - An identifier of the subject who carried out the experiment.
names(subjectall) <- "subject"

# need to recreate all data since the contain of subjectall changed
alldata           <- cbind(subjectall, yall, xall)

# Pattern changes
names(alldata) <- gsub("^t", "time-", names(alldata))
names(alldata) <- gsub("^f", "frequency-", names(alldata))

names(alldata) <- gsub("Acc", "Accelerometer", names(alldata))
names(alldata) <- gsub("Gyro", "Gyroscope", names(alldata))
names(alldata) <- gsub("Mag", "Magnitude", names(alldata))
names(alldata) <- gsub("BodyBody", "Body", names(alldata))
names(alldata) <-        gsub("\\()", "", names(alldata))
# ------------------------------------------------------------------------
# 5. From the data set in step 4 (prior step), creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
# Found out this can also be possible using ddply fron library(plyr) as displayed 
# in lectures, but decided to use aggregate since I like it more from # library(stats)
# ------------------------------------------------------------------------

# summarize data
alldata_grouped <- aggregate(. ~subject + activity, data=alldata, FUN= mean)

# ------------------------------------------------------------------------
# Extra step:
# Create txt file with write.table() using row.name=FALSE
# for the tidy data set created in step 5 of the instructions. 
# ------------------------------------------------------------------------


# write file to output
write.table(alldata_grouped, file=file.path(root_path,"alldata-grouped.txt"),row.name=FALSE, sep = "\t", append=F)

