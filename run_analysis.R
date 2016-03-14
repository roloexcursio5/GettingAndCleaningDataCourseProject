# DATA
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
# Download project info
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)		# add method="curl" if not working with windows
}
# unzip project info  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# FEATURES
# import de features that are the column names (it only imports the second column that is the one with the names)
features <- as.vector(read.table("./UCI HAR Dataset/features.txt")[[2]])
# identify de columns that are included in the project: the measurements on the mean and standard deviation for each measurement 
featuresToBeImported_colindex <- grep("mean\\(\\)|std\\(\\)", features)
# modify features names
features <- gsub("mean\\(\\)","_mean", features)
features <- gsub("std\\(\\)","_std", features)
features <- gsub("-","", features)


# TRAIN
# import train subjects
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="subject")
# import train activities
train_activities <- read.table("./UCI HAR Dataset/train/Y_train.txt",col.names="activity")
# import train measurements data set
train_measurements <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names=features)[featuresToBeImported_colindex]
# join the three data sets and identifies themm as train dataset
train <- cbind(sample="train",train_subjects,train_activities,train_measurements)


# TEST
# import test subjects
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="subject")
# import test activities
test_activities <- read.table("./UCI HAR Dataset/test/Y_test.txt",col.names="activity")
# import test measurements data set
test_measurements <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names=features)[featuresToBeImported_colindex]
# join the three data sets and identifies themm as test dataset
test <- cbind(sample="test",test_subjects,test_activities,test_measurements)


# MERGE
# merge train and test data set and make subjet a factor
train_test <- rbind(train,test)
train_test$subject <- as.factor(train_test$subject)


# ACTIVITIES
# import activity_labels to use it for its description
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("activity","activity_description"))
# replace activity code for activity description in train_test
library(plyr)
train_test <- join(train_test,activity_labels,by="activity")[,c(1,2,70,4:69)]


# MELT AND MEAN
library(reshape2)
train_test_melted <- melt(train_test, id=c("subject","activity_description"), measure.vars=4:69)
train_test_melted_mean <- dcast(train_test_melted, subject + activity_description ~ variable, mean)


write.table(train_test_melted_mean, "tidy.txt",row.names = FALSE)