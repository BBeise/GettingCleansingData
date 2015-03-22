# preliminary stuff
library(dplyr)
library(tidyr)
# read in the datasets
activity_labels <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/activity_labels.txt", quote="\"")
subject_test <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/train/subject_train.txt", quote="\"")
features <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/features.txt", quote="\"")
y_test <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/train/y_train.txt", quote="\"")
X_train <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("~/Google Drive/Training/Data Science/Getting Cleansing Data/Class Project/UCI HAR Dataset/test/X_test.txt", quote="\"")
# Step 1 from Project Instruction - Merge the test and training datasets
# SubStep 1.1 - creating a Test/Train identifier to the subject tables
  subj_test_in<-data.frame(subject_test)
  subj_test_in$group<-"TEST"
  subj_train_in<-data.frame(subject_train)
  subj_train_in$group<-"TRAIN"
# SubStep 1.2 - rowbinding the test/train subject files to the subject_files
# for each row - output: a_subject
  a_subject<-data.frame(rbind(subj_test_in,subj_train_in))
# SubStep 1.3 - rowbinding and labelling the test/train activity files - output: b_activity
  b_activity<-data.frame(rbind(y_test,y_train))
  colnames(b_activity)<-c("actcode")
# SubStep 1.4 - rowbinding the test and training data files and applying colnames - output: c_data
  c_data<-data.frame(rbind(X_test,X_train))
  names.cdata<-t(features)
  colnames(c_data)<-names.cdata[2,]
# SubStep 1.5 - colbinding the subject file to the activity file to the data file - output: comb_raw
  comb_raw<-cbind(a_subject,b_activity,c_data)
# Step 2 - Extract the measurements on the mean and standard deviation for each measurement
# SubStep 2.1 - identify the variables of interest and subset on that list
  variables <- grep("std|mean|Mean",features[,2],value=TRUE)
  comb_sub1<-comb_raw[,1:3]
  comb_sub2<-comb_raw[,variables]
  comb_dat<-cbind(comb_sub1,comb_sub2)
# Step 3 - apply activity name through merge
  names(activity_labels)<-c("actcode","ACTIVITY")  
  mergefile<-merge(activity_labels,comb_dat,by.x="actcode",by.y="actcode",all=TRUE)
# Step 4 - label data set with appropriate variable names
  colnames(mergefile)[3] <- "SUBJID"
# Step 5 - create tidy data set of average of each variable for each activity and each subject
#############  unable to complete step 5 by submission date 




