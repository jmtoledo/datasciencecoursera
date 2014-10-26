
# Getting and Cleaning Data: Script for Course Proyect 
# Author : jmtoledo@yahoo.com
# Data: October / 2014

# Object : merging two datasets and extract the mean and the standard
#          desviation of each measurement. Datas are separated because
#          some individuals are in the group of test and the other don´t.
#
# Data inputs downloaded previously from : 
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# and stored in the default directory
#
# Files:
# train/X_train.txt: Training set.
# train/y_train.txt: Training labels.
# test/X_test.txt: Test set.
# test/y_test.txt: Test labels.
# test/subject_test.txt   // the identifier of the individuals in test group
# train/subject_train.txt   // the identifier of the individuals in train group



# 1, Merges the training and the test sets to create one data set.

# All files are without header inside, so has the default value of read.table

# Read the test files:
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Individuals_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read the train files
Xtrain  <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytrain  <-read.table("./UCI HAR Dataset/train/Y_train.txt")
Individuals_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read the activitylabels and features files (has the columns names of the data)
ativityLabels = read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt") 

# name it
names(Xtest)<-features[,2]
names(Xtrain)<-features[,2]
names(Ytest)<-c("Activity")
names(Ytrain)<-c("Activity")
names(Individuals_train<-c("Subject")
names(Individuals_test<-c("Subjet")
      
# extract only the columns with std or mean in it
columns_we_need<- grepl("-mean()|-std()", features[,2])
Xtestfiltered<-Xtest[,columns_we_need]
Xtrainfiltered<-Xtrain[,columns_we_need]

# First join by columns IndividualNumber,X,Y values in the same table
# for two datasets. The tables has the same number of rows.

# Adding data by columns of the same type of individuals
test <-cbind(Individuals_test,Xtestfiltered,Ytest)
train<-cbind(Individuals_train,Xtrainfiltered,Ytrain)

# Then, merging two tables by rows, into a one with all individuals

AllDatasetfiltered <- rbind(test,train)


# Uses descriptive activity names to name the activities in the data set

AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 1] = "WALKING"
AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 2] = "WALKING_UPSTAIRS"
AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 3] = "WALKING_DOWNSTAIRS"
AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 4] = "SITTING"
AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 5] = "STANDING"
AllDatasetfiltered$Activity[AllDatasetfiltered$Activity == 6] = "LAYING"

# creates tidy data set with the average of each variable for each activity and each subject

library(plyr)

AllDatasetfiltered$Activity <- as.factor(AllDatasetfiltered$Activity)
AllDatasetfiltered$Subject <- as.factor(allData$Subject)

tidy = aggregate(AllDatasetfiltered, by=list(Activity = AllDatasetfiltered$Activity, Subject=AllDatasetfiltered$Subject), mean)
write.table(tidydataset, "tidydataset.txt", sep="\t")
