# set working directory
setwd("i:\\Coursera\\Getting cleaning\\PeerAss\\UCI HAR Dataset\\")
#1------------------------------------------------------------------------------
# Merges the training and the test sets to create one data set.
# - read files of column names and change the name of them to be compatible with R
variable<-read.delim("./features.txt",header=F,sep=" ",na.strings = c("NA"), dec = ".")[,2]
variable1<-gsub("[(]","",variable, perl=T)
variable2<-gsub("[)]","",variable1, perl=T)
variable3<-gsub("[,]","",variable2, perl=T)
variables<-gsub("[-]","",variable3, perl=T)
# - read and combine subject data
subject<-rbind(read.delim("./test/subject_test.txt",header=F, col.names="subject"),
               read.delim("./train/subject_train.txt",header=F, col.names="subject"))
# - read and combine test and train data
preDATA<-rbind(read.table("./test/X_test.txt",header=F,sep="", dec = ".",na.string=" ", col.names=variables),
            read.table("./train/X_train.txt",header=F,sep="",na.strings = " ", dec = ".",col.names=variables))
# - add train data to data set
DATA<-cbind(preDATA,subject)
summary(DATA)
names(DATA)

#2------------------------------------------------------------------------------
# Extracts only the measurements on the mean and standard deviation for each measurement. 
mean.std.names<-c(sort(c(grep("mean",colnames(DATA),ignore.case=F), grep("std",colnames(DATA),ignore.case=F))),562)
mean.std.DATA<-DATA[,mean.std.names]

#3------------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#  read file with labels
label<-read.delim("./activity_labels.txt",header=F, sep=" ", col.names=c("activity.id","activity.lables"))
#  read files with activity
activity.pre<-rbind(read.delim("./test/y_test.txt",header=F, col.names="activity"),
                    read.delim("./train/y_train.txt",header=F,  col.names="activity"))
#  give names of acitvity
activity<-merge(x=activity.pre,y=label, 
                by.x="activity", by.y="activity.id", all.y=F, all.x=F)
#  add column with activity and activity labels
data.set<-cbind(mean.std.DATA,activity)
summary(data.set)
head(data.set)
#4------------------------------------------------------------------------------
# Appropriately labels the data set with descriptive activity names
# - have been done in step 1
colnames(data.set)

#5------------------------------------------------------------------------------
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ftable(data.set$subject~data.set$activity.lables)

table(data.set$subject)
table(data.set$activity)

ftable(data.set$activity~data.set$subject)

subj1<-data.set[data.set$subject=="1"&data.set$activity=="2",]
  
write
