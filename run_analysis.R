# Check needed packages to be installed first and load them for use
if(!is.element('utils', installed.packages()[,1]))install.packages('utils')
if(!is.element('dplyr', installed.packages()[,1]))install.packages('dplyr')
if(!is.element('tidyr', installed.packages()[,1]))install.packages('tidyr')

library("utils")
library("dplyr")
library("tidyr")

# Set up working directory
setwd("C:/Users/YUCHOUCHEN/Documents/R programming/GetData/CourseProject/GetData_CourseProject_UCI-HAR-Dataset")

# Name input files
inFileTrainX <- "./UCI HAR Dataset/train/X_train.txt"
inFileTrainy <- "./UCI HAR Dataset/train/y_train.txt"
inFileTrainsubj <- "./UCI HAR Dataset/train/subject_train.txt"

inFileTestX <- "./UCI HAR Dataset/test/X_test.txt"
inFileTesty <- "./UCI HAR Dataset/test/y_test.txt"
inFileTestsubj <- "./UCI HAR Dataset/test/subject_test.txt"

inFileFeatures <- "./UCI HAR Dataset/features.txt"
inFileActLabels <- "./UCI HAR Dataset/activity_labels.txt"

# Name output file
outFile <- "./run_analysisOutput.txt"

# Read data
dataTrainX <- read.table(inFileTrainX, sep= "", dec = ".", strip.white = TRUE)
dataTrainy <- read.table(inFileTrainy)
dataTrainsubj <- read.table(inFileTrainsubj)

dataTestX <- read.table(inFileTestX, sep= "", dec = ".", strip.white = TRUE)
dataTesty <- read.table(inFileTesty)
dataTestsubj <- read.table(inFileTestsubj)

dataActLabels <- read.table(inFileActLabels)

# 1. Merges the training and the test sets to create one data set.
# Merge
dataX <- rbind(dataTrainX, dataTestX)
datay <- rbind(dataTrainy, dataTesty)
datasubj <- rbind(dataTrainsubj, dataTestsubj)

# Read Features' names from 'features.txt' and use them as column's name of dataX
# And using paste function and "_" to combine column 1 and column 2 to avoid 
#    duplicated column names occurred in lines 303 to 344, 382 to 423, 461 and 502.
dataFeatures <- read.table(inFileFeatures, sep= "")
names(dataX) <- paste(dataFeatures[,1], dataFeatures[,2], sep = "_")

# Adjust the column name using Regular Expression
tempColumn <- gsub("[()\\,]", "_", names(dataX)) # replace "(", ")", "," with "_"
tempColumn <- gsub("_{2,}", "_", tempColumn) # replace "__" or "___" with "_"
tempColumn <- gsub("_-", "-", tempColumn) # replace "_-" with "-"
names(dataX) <- gsub("_$", "", tempColumn) # remove "_" at the end

# Assign column name of y and subject
names(datasubj) <- "Subject"
names(datay) <- "Activity_label"

# 3. Uses descriptive activity names to name the activities in the data set
# Convert activity number to activity label
lengthActLabels <- length(dataActLabels$V2)
for (i in 1:lengthActLabels) {
      datay[datay == i] <- as.character(dataActLabels[i,2])
}

# Column bind X, subj, y
dataAll <- cbind(dataX, datasubj, datay)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 4. Appropriately labels the data set with descriptive variable names. 
# Select columns with Mean or mean or Std or std wording, 
# and adjust the column name of selected using Regular Expression
RegEx_vars <- "Mean|mean|Std|std"
selected <- select(dataAll, matches(RegEx_vars), Subject, Activity_label)
names(selected) <- gsub("\\d{1,3}_", "", names(selected))

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Declare the Goal array with 3 dimensions of [1st, 2nd, 3rd]
# 1st dimension = subject number
# 2nd dimension = row of Activity Label
# 3rd dimension = column name with mean or std

lengthColumn <- length(names(selected)) - 2 # -2 means to subtract "Subject" and "Activity_label"
SubjectTotal <- 30 # Total subjects = 30
nameSelected <- names(selected)

Goal <- array("", dim = c(SubjectTotal, lengthActLabels, lengthColumn))

# Assign the names of dimension of Goal
dimnames(Goal) = list(1:SubjectTotal, dataActLabels$V2, nameSelected[1:lengthColumn])

# Main loop to get the answers for this "Course Project"
# Get the average (i.e. mean) of each variable for each activity and each subject
for (iSub in 1:SubjectTotal){
      for (iActLabel in 1:lengthActLabels){
           # temp <- filter(selected, Subject == iSub & Activity_label == dataActLabels$V2[iActLabel])
           # temp <- select(temp, -Subject, -Activity_label)
           # iAct <- colMeans(temp)
            selected %>%
            filter(Subject == iSub & Activity_label == dataActLabels$V2[iActLabel]) %>%
            select(-Subject, -Activity_label) %>%
            colMeans -> iAct
            
            if(iActLabel == 1) {
                  SubjectAct <- iAct
            } else {
                  SubjectAct <- rbind(SubjectAct, iAct)
            }
      }
      Goal[iSub, ,] <- SubjectAct
}

# Change the class of Goal values from character to numeric
class(Goal) <- "numeric"

# Output
write.table(Goal, file = outFile, row.names = FALSE)
