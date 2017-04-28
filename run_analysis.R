run_analysis <- function(){
     library(dplyr)
     
     ##Import necessary tables to construct combined data set
     features <- read.table("./features.txt")
     subjectTrain <- read.table("./train/subject_train.txt")
     subjectTest<- read.table("./test/subject_test.txt")
     xTrain <- read.table("./train/X_train.txt")
     yTrain <- read.table("./train/y_train.txt")
     xTest<- read.table("./test/X_test.txt")
     yTest<- read.table("./test/y_test.txt")
     
     ##use rbind and cbind to assemble data set
     combinedSubject<-rbind(subjectTrain,subjectTest)
     combinedY<- rbind(yTrain,yTest)
     combinedX<- rbind(xTrain,xTest)
     combinedData<- cbind(combinedSubject,combinedY,combinedX)
     
     ##use colnames to create appropriate and clean variable titles
     colnames(combinedData)<-c("Subject","Activity",as.vector(features[,2]))
     
     ##use grep to search for only the columns pertaining to mean or std and remove the rest
     keepCol<-grep("Subject|Activity|mean|std",colnames(combinedData))
     combinedData<-combinedData[,keepCol]
     
     ##go through activity column and replace integer values with
     ##correspoinding activity titles
     ##change column to character to avoid NA when coerced
     activities<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
     combinedData$Activity<- as.character((combinedData$Activity))
     
          for(i in seq_along(activities)){
               combinedData$Activity[combinedData$Activity == as.character(i)]<-activities[i]
          }
     
     ##set subject and activity as factors to facilitate
     ##grouping and creation of final table
     combinedData$Subject<-as.factor(combinedData$Subject)
     combinedData$Activity<-as.factor(combinedData$Activity)
     
     finalData<-combinedData %>% group_by(Subject,Activity) %>% summarise_each(funs(mean(.,na.rm = TRUE)),-Subject,Activity)
     
     write.table(finalData,file = "./cleanedData.txt")
     return(finalData)
}