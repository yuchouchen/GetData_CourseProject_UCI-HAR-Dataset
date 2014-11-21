==== Part 1: Following are modified based on the feature_info.txt in "UCI HAR Dataset" sub-directory ====
Feature Selection 
-----------------

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

(prefix 't' to denote time domain signals)
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag

(prefix 'f' to denote frequency domain signals)
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables for mean and std that were estimated from these signals are: 
('-mean', '-std', '-meanFreq' are used to denote the set of variables separately)
mean: Mean value
std: Standard deviation
meanFreq: Weighted average of the frequency components to obtain a mean frequency
(NOTE: Other set of variables will not be selected for the exercise of this Course Project)

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in the 'features.txt' file

==== Part 2: Following is the brief description of transformation of column names ====
Please refer lines from 45 to 55 of 'run_analysis.R'

(1) Read Features' names from 'features.txt' and use them as column's name of dataX
    And using paste function and "_" to combine column 1 and column 2 to avoid 
        duplicated column names occurred in lines 303 to 344, 382 to 423, 461 and 502.
	
	Following quoted from Discussion Forums posted by David Hood (Community TA):
	the people who put the data together made mistakes. As the duplicates come in threes, the main theory is they forgot to add x, y, and z to those entries. It is a bit like the BodyBody mistake entries.
	Source: https://class.coursera.org/getdata-009/forum/thread?thread_id=176

(2) Adjust the column name using Regular Expression
Note: 'dataX' represents the combined result of two column names of 'features.txt'

replace "-", "(", ")", "," with "_" for names(dataX) if have
replace "(", ")", "," with "_" for names(dataX) if have
replace "__" or "___" with "_" for names(dataX) if have
replace "_-" with "-" for names(dataX) if have
remove "_" at the end for names(dataX) if have

==== Part 3: Following is the brief description of select column names with "Mean", or "mean", or "Std", or "std" ====
Please refer lines from 71 to 77 of 'run_analysis.R'

Extracts only the measurements on the mean and standard deviation for each measurement.
Appropriately labels the data set with descriptive variable names. 
Select columns with Mean or mean or Std or std wording, 
and adjust the column name of selected using Regular Expression

===============================================================================
Reference (posted by Kirsten Frank (COMMUNITY TA)):
The minimum for a codebook for this project is to 
1) copy over the feature_info.txt, 
2) remove all columns that have been removed, 
3) rename the columns that have been renamed, and 
4) state the transformation. 

Source: https://class.coursera.org/getdata-009/forum/thread?thread_id=89

===============================================================================
Contributor:
YuChou Chen (Joe Chen)

