library(data.table)  #######loading the data table package

############# loading all the data sets
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
X_train<- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt")
X_test<- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <-read.table("UCI HAR Dataset/test/subject_test.txt")
######## - merging the data set to each other
DatasetY<-rbind(Y_test, Y_train)
subject<-rbind(subject_test, subject_train)
DatasetX<-rbind(X_test, X_train)
#######  isolating only the mean and standard deviation columns and placing them in new data sets
index<-grep("mean\\(\\)|std\\(\\)", features[,2]) 
DatasetX<-DatasetX[,index] 
DatasetY[,1]<-activity[DatasetY[,1],2] 
#######Assigning names to each column so no longer have to use names like V1 V2 etc
names<-features[index,2] 
names(DatasetX)<-names 
names(subject)<-"SubjectID"
names(DatasetY)<-"Activity"
###### Combine all columns from data sets into one 
Combined <-cbind(subject,DatasetY,DatasetX)
#####Class into a data table
Combined <-data.table(Combined)
#####Allows to get averages of standard deviation assign to final dataset
NewDataSet <- Combined[, lapply(.SD, mean), by = 'SubjectID,Activity'] 
