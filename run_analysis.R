## load libraries
library(dplyr)

## set initial variables
inputdata <- "originaldata/UCI HAR Dataset"
outputdata <- "outputdata"
outputfile <- "tidy_data.csv"
outputsummarizedfile <- "data_summarized.csv"
outputsummarizedtablefile <- "data_summarized.txt"

## load original files
test_X <- read.table(file.path(inputdata,"test","X_test.txt"),sep="",header=FALSE)
test_y <- read.table(file.path(inputdata,"test","y_test.txt"),sep="",header=FALSE)
subject_test <- read.table(file.path(inputdata,"test","subject_test.txt"),sep="",header=FALSE)

train_X <- read.table(file.path(inputdata,"train","X_train.txt"),sep="",header=FALSE)
train_y <- read.table(file.path(inputdata,"train","y_train.txt"),sep="",header=FALSE)
subject_train <- read.table(file.path(inputdata,"train","subject_train.txt"),sep="",header=FALSE)

labels <- read.table(file.path(inputdata,"features.txt"),sep="",header=FALSE)
activities <- read.table(file.path(inputdata,"activity_labels.txt"),sep="",header=FALSE)

## compose new data variable
labels <- c("subject",labels[,2],"activity")
data_X <- rbind(train_X,test_X)
data_y <- rbind(train_y,test_y)
subject <- rbind(subject_train,subject_test)
data <- cbind(subject,data_X,data_y)

## change column names
colnames(data) = labels

## get on mean and std columns
selectedlabels<-grep("(mean|std)",labels)
selectedlabels<-c(1,selectedlabels,563)
data <- data[,selectedlabels]

## set activity name (Including adjust of column name)
data <- merge(data,activities,by.x="activity",by.y="V1")
data<-data[,c(2,82,3:81)]
labels <- colnames(data)
labels[2] <- "activity"
colnames(data) <- labels

## create output directory
if (!dir.exists(outputdata)){
  dir.create(outputdata)
}

## output data
if (file.exists(file.path(outputdata,outputfile))){
  file.remove(file.path(outputdata,outputfile))
}
write.csv(data,file.path(outputdata,outputfile),row.names = FALSE)

## summarize data
data <- tbl_df(data)
data <- group_by(data,subject,activity)
data_summarized <- summarize_all(data,mean)

## output summarized data
if (file.exists(file.path(outputdata,outputsummarizedfile))){
  file.remove(file.path(outputdata,outputsummarizedfile))
}
write.csv(data_summarized,file.path(outputdata,outputsummarizedfile),row.names = FALSE)
write.table(data_summarized,file.path(outputdata,outputsummarizedtablefile),row.name=FALSE)

## remove variables with original data
rm(test_X)
rm(test_y)
rm(train_X)
rm(train_y)
rm(subject_test)
rm(subject_train)
rm(data_X)
rm(data_y)
rm(subject)
rm(labels)
rm(selectedlabels)
rm(activities)
rm(data)
rm(data_summarized)
rm(inputdata)
rm(outputdata)
rm(outputfile)
rm(outputsummarizedfile) 