library(reshape2)
library(dplyr)

# You should create one R script called run_analysis.R that does the following.

# Step 1: Merges the training and the test sets to create one data set

# Step 1.1: Download and Unzip the Data
DataFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
if(!file.exists(DataFile))
  {fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, DataFile, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
#Step 1.2: Get variable names
features <- read.table("UCI HAR Dataset/features.txt")
features2 <- as.character(features[,2])

# Step 1.3: Load training and test sets
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
X_test = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features2)
Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")

subject_training = read.table("UCI HAR Dataset/train/subject_train.txt")
X_training = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features2)
Y_training = read.table("UCI HAR Dataset/train/Y_train.txt")

# NOTE: This method will change the name of some columns ("Energy"), in a way that doesn't affect further analysis for
# this particular exercise.

# Step 1.3: Merge test and training sets / rename variables for manipulation
subject_test_training <- rbind(subject_test, subject_training)
subject_test_trainingREN <- rename(subject_test_training, subjectID = V1)

X_test_training <- rbind(X_test, X_training)

Y_test_training <- rbind(Y_test, Y_training)
Y_test_trainingREN <- rename(Y_test_training, Activity = V1)

MergedData <- cbind(subject_test_trainingREN, Y_test_trainingREN, X_test_training)
length(names(MergedData)) == length(unique(names(MergedData)))

#Final result is complete Data Set with working variable names.

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

SelectMergedData <- select(MergedData, subjectID, Activity, matches("mean"), matches("std"))
names(MergedData)<-make.names(names(MergedData),unique=TRUE)

# check for duplicates with length(names(SelectMergedData)) == length(unique(names(SelectMergedData)))
# alternative: names(MergedData)<-make.names(names(MergedData),unique=TRUE)

# Step 3: Uses descriptive activity names to name the activities in the data set

# Step 3.1: Load Activity Labels and reformat -> Descriptive
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt") 
activityLabels2 <- as.character(activityLabels[,2])
activityLabels3 <- tolower(activityLabels2)
activityLabels4 <- sub("_", " ", activityLabels3)
activityLabels5 <- stringr::str_to_title(activityLabels4)

# Step 3.2: Rename activities in data set
SelectMergedData$Activity <- factor(SelectMergedData$Activity, c(1:6), activityLabels5)

# Step 4: Appropriately labels the data set with descriptive variable names.

names(SelectMergedData)<-gsub("^t", "time of ", names(SelectMergedData))
names(SelectMergedData)<-gsub("^f", "frequency of ", names(SelectMergedData))
names(SelectMergedData)<-gsub("Acc", "Accelerometer ", names(SelectMergedData))
names(SelectMergedData)<-gsub("Gyro", "Gyroscope ", names(SelectMergedData))
names(SelectMergedData)<-gsub("Mag", "Magnitude ", names(SelectMergedData))
names(SelectMergedData)<-gsub("BodyBody", "Body ", names(SelectMergedData))
names(SelectMergedData)<-gsub("jerk", "Jerk ", names(SelectMergedData))
names(SelectMergedData)<-gsub("Body", "Body ", names(SelectMergedData))

# Final result of Step 4 is labels that are more understandable.

# Step 5: From the data set in step 4, creates a second, independent tidy data set with 
## the average of each variable for each activity and each subject.

#Reshaping with melt and dcast (Lesson 4 of week 3)

DataMelt <- melt(SelectMergedData, id=c("subjectID", "Activity"))
DataMelt2 <- dcast(DataMelt, subjectID + Activity ~ variable, mean)

write.table(DataMelt2, "./DataMelt2.txt", row.name=FALSE)


