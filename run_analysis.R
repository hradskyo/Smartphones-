# set working directory
setwd("i:\\Coursera\\Getting cleaning\\PeerAss\\UCI HAR Dataset\\")
#1------------------------------------------------------------------------------
# Merges the training and the test sets to create one data set.
# - read files of column names and change the name of them to be compatible with R
#4------------------------------------------------------------------------------
# Appropriately labels the data set with descriptive activity names
variable<-read.delim("./features.txt",header=F,sep=" ",na.strings = c("NA"), dec = ".")[,2]
variable1<-gsub("[(]",".",variable, perl=T)
variable2<-gsub("[)]","",variable1, perl=T)
variable3<-gsub("[,]","",variable2, perl=T)
variables<-gsub("[-]","",variable3, perl=T)
# - read and combine subject data
subject<-rbind(read.delim("./test/subject_test.txt",header=F, col.names="subject"),
               read.delim("./train/subject_train.txt",header=F, col.names="subject"))
#  read files with activity id
activity.id<-rbind(read.delim("./test/y_test.txt",header=F, col.names="activity.id"),
                   read.delim("./train/y_train.txt",header=F,  col.names="activity.id"))
# - read and combine test and train data
preDATA<-rbind(read.table("./test/X_test.txt",header=F,sep="", dec = ".",na.string=" ", col.names=variables),
               read.table("./train/X_train.txt",header=F,sep="",na.strings = " ", dec = ".",col.names=variables))
# - combine all data with subject and activity id 
DATA<-cbind(preDATA,subject,activity.id)
#3------------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#  read file with labels
label<-read.delim("./activity_labels.txt",header=F, sep=" ", col.names=c("activity.id","activity.labels"))
#  add names of activity
data.set<-merge(x=DATA,y=label,by.x="activity.id", 
                by.y="activity.id", all.y=T, all.x=T, sort=F)
#2------------------------------------------------------------------------------
# Extracts only the measurements on the mean and standard deviation for each measurement. 
mean.std.names<-c(sort(c(grep("mean[.]",names(data.set),ignore.case=F), 
                         grep("std[.]",colnames(data.set),ignore.case=F))),563,564)
mean.std.DATA<-data.set[,mean.std.names]
#head(data.set)
#colnames(data.set)
#5------------------------------------------------------------------------------
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
#  compute all means for all subject and all activity
pre.final.data<-NULL
for (i in 1:max(mean.std.DATA$subject)) {
  dat<-mean.std.DATA[mean.std.DATA$subject==i,]
  for (j in 1:6) {
    dat2<-dat[dat$activity.labels==paste(label[j,2]),]
    vys<-as.vector(sapply(dat2[1:66],mean))
    pre.final.data<-rbind(pre.final.data,vys)
  }
}
# gives rownames to new data set
rownames(pre.final.data)<-1:180
# adds subject and activity
final.data<-as.data.frame(cbind(rep(1:30,each=6),paste(label[,2]),pre.final.data))
# gives colnames to new data set
colnames(final.data)<-c("subject","activity",names(mean.std.DATA[1:66]))
# create a file with new independent data set
write.table(file="./tide_data_set.txt",x=final.data)
# checking format after reading from the file: OK
new.data.set<-read.table(file="./tide_data_set.txt")
ftable(new.data.set$subject,new.data.set$activity)
summary(new.data.set)
# END
