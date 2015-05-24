

target_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
target_localfile = "./data/Dataset.zip"

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
                                

xall       <- rbind(xtrain, xtest)
yall       <- rbind(ytrain, ytest)
subjectall <- rbind(subjecttrain, subjecttest)
alldata    <- cbind(subjectall, yall, xall)


selected_fields_mean_std<- grep("-(mean|std)\\(\\)", features[, 2])

alldata_grouped <- aggregate(. ~subject + activity, data=alldata, FUN= mean)

write.table(alldata_grouped, file=file.path(root_path,"alldata-grouped.txt"),row.name=FALSE, sep = "\t", append=F)

