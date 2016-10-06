 
##merger all test files,dim(2964*563)
Test_activity<-read.table("UCI HAR Dataset/test/y_test.txt",header=T)
Test_features<-read.table("UCI HAR Dataset/test/X_test.txt",header=T)
Test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt",header=T)
dataTest<-cbind(Test_activity,Test_subject,Test_features)
##merge all train files,dim(2964*563)
Train_activity<-read.table("UCI HAR Dataset/train/y_train.txt",header=T)
Train_features<-read.table("UCI HAR Dataset/train/X_train.txt",header=T)
Train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt",header=T)
dataTrain<-cbind(Train_activity,Train_subject,Train_features)

##unify colnames and merger test & train dataset,dim(7351*563)
colnames(dataTest)<-c(1:563)
colnames(dataTrain)<-c(1:563)
data<-rbind(dataTest, dataTrain)

##make logic index for subsetting the mean and standard deviation
featureLabels<-read.table("UCI HAR Dataset/features.txt",header=F)
Index<-grepl("mean()",featureLabels$V2, fixed = TRUE) | grepl("std()", featureLabels$V2, fixed = TRUE)
subset<-c(TRUE,TRUE,Index)
subsetData<-data[ ,subset]
##show activity names in the column1.
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt",header=F)
activity<-as.character(activityLabels[,2])
for(i in 1:6){
    subsetData[subsetData[,1]==i,1]=activity[i]
}
##show column names of features
featureName<-as.character(featureLabels$V2[Index])
featureName<-sub("-X","Xaxial",featureName)
featureName<-sub("-Y","Yaxial",featureName)
featureName<-sub("-Z","Zaxial",featureName)
featureName<-sub("-mean\\(\\)","Mean", featureName)
featureName<-sub("-std\\(\\)", "S", featureName )  ##avoid t be replaced by time
featureName<-sub("BodyBody", "Body",featureName)
featureName<-sub("f","Freq",featureName)
featureName<-sub("t","Time",featureName)
featureName<-sub("S", "StandardDeviation", featureName)
colnames(subsetData)<-c("Activity","Subject",featureName)
##creates a second, independent tidy data set with the average of each variable  
s<-data.frame(matrix(nrow=180,ncol=68))
for(j in 1:6){
d<-subsetData[subsetData$Activity==activityLabels[j,2], ]
k<-c((j*30-29):(j*30))
for(i in 3:68){
   s[k,i]<-tapply(d[ ,i], d$Subject, mean)
}
}
s[1]<-rep(activityLabels$V2,each=30)
s[2]<-rep(c(1:30),6)
colnames(s)<-c("Activity","Subject",featureName)
write.table(s, file = "F:/niniProgramming/cleanDate/course project/tidyData.txt", sep="\t", row.names = F)

