features<-read.table("UCI HAR Dataset/features.txt",sep = "",header = FALSE,fill = TRUE)
activity<-read.table("UCI HAR Dataset/activity_labels.txt",sep = "",header = FALSE,fill = TRUE)

X_test<-read.table("UCI HAR Dataset/test/X_test.txt",sep = "",header = FALSE,fill = TRUE)
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",sep = "",header = FALSE,fill = TRUE)
Y_test<-read.table("UCI HAR Dataset/test/y_test.txt",sep = "",header = FALSE,fill = TRUE)

X_train<-read.table("UCI HAR Dataset/train/X_train.txt",sep = "",header = FALSE,fill = TRUE)
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt",sep = "",header = FALSE,fill = TRUE)
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt",sep = "",header = FALSE,fill = TRUE)

########Merges the training and the test sets to create one data set.
x_plus_subject_test<-cbind(X_test,subject_test)
#final test
test_data<-cbind(x_plus_subject_test,Y_test)

x_plus_subject_train<-cbind(X_train,subject_train)
#final test
train_data<-cbind(x_plus_subject_train,Y_train)

features<-rbind(features,data.frame(V1=562,V2="subject"))
features<-rbind(features,data.frame(V1=563,V2="activity"))

colnames(test_data)<-features[,2]
colnames(train_data)<-features[,2]

data<-rbind(test_data,train_data)
#######################################################################
#Extracts only the measurements on the mean and standard deviation for each measurement. 
columnIndexVector<-sort(c(grep("std",colnames(data)),grep("mean",colnames(data)),grep("subject",colnames(data)),grep("activity",colnames(data))))

dataStdMean<-data[,columnIndexVector]
#######################################################################
#Uses descriptive activity names to name the activities in the data set

library(dplyr)
library(plyr)
dataStdMeanActivity<-merge(dataStdMean,activity,by.x = "activity",by.y = "V1",all = TRUE)
names(dataStdMeanActivity)[names(dataStdMeanActivity)=="V2"]<-"ActivityName"
dataStdMeanActivity$activity<-NULL

#######################################################################
#Appropriately labels the data set with descriptive variable names. 

namesVector<-colnames(dataStdMeanActivity)
namesVector<-gsub("-s","S",namesVector)
namesVector<-gsub("-m","M",namesVector)
namesVector<-gsub("\\(\\)","",namesVector)
namesVector<-gsub("-","",namesVector)
namesVector<-gsub("^t","Time",namesVector)
namesVector<-gsub("^f","Frequency",namesVector)
namesVector<-gsub("Acc","Acceleration",namesVector)
colnames(dataStdMeanActivity) <- namesVector

#######################################################################
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

grpBy_Activity_Subject<-group_by(dataStdMeanActivity,subject,ActivityName)

theFinalSummary<-summarize_each(grpBy_Activity_Subject,funs(mean))

write.table(theFinalSummary,file="theFinalSummary.txt",row.names = FALSE)
