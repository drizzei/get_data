---
title: "CODEBOOK"
output: html_document
---
The observations in these documents represent measurements "from the accelerometer and gyroscope 3-axial raw signals (UCI)" from thirty subjects wearing Samsung Galaxy sII smartphones on their waists.

The data from the UCI HAR dataset (described in more detail below) was separated into 8 files. Thirty subjects were involved in the study. The observations were divided into a training and a test set.

The initial step in cleaning the data was combining the training and test set into a single dataset (Although, they could reasonably have been cleaned separately).

Each set (training and test) contained three files named (X, y, and subject). The "X" text files contained the measurements taken from the mobile devices. 

The "y" text files contained the numeric ids the "Activities" as below

- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

The "subject" text files contained numeric ids for the subjects.

After combining the data, each subset of data (X, y, subject) consisted of 10,299 variables. 

To create a tidy data set, the data was arranged so that the observations from the whole experiment were contained in a single table. Each row contains a single observation and each column provides a single variable.   

Subject (integers from 1 to 30) provides a numeric id for the individual subject.

Activity indicates which one of six activities a subject was undertaking when a measurement was taken (LAYING, SITTING, STANDING, WALKING, WALKING DOWNSTAIRS, WALKING UPSTAIRS). 

** THE REMAINING VARIABLES ARE CALCULATED MEANS OF THE ORIGINAL DATASET. THE DATA IS PROVIDED AS THE MEAN OF THE MEASUREMENTS FOR EACH ACTIVITY FROM EACH SUBJECT **

The remaining variables represent the individual features as described in the features_info.txt document from the UCI HAR data set (provided below and edited to include only measurements of means and standard deviations)

(citation: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

  "The features selected for this database come from the accelerometer and       gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
  
  Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
  
  Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
  
  These signals were used to estimate variables of the feature vector for each pattern:  
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."
  
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- meanFreq(): Weighted average of the frequency components to obtain a mean - - - - frequency
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean
