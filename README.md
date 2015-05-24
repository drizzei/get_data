---
title: "CODEBOOK"
output: html_document
---

This document describes the process of collecting and manipulating data from the UCI Human Activity Recognition dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Output of a tidy data set was produced using R's write.table() function and can be best read by using the read.table() function in R (as David Hood describes in his thread from the Getting and Cleaning Data course from Coursera) 

```{r}
  data <- read.table(file_path, header = TRUE)
  #With file_path being the local destination for the downloaded text file
  View(data)
```

The file run_analysis.R contains the code used to create the final dataset and will be described in blocks below. More detailed information about the variables and files can be found in the document "CODEBOOK.md" in this repository.

---
---
Download Data from the UCI repository
---
---
```{r}
library(downloader)
#The downloader package avoids some of the issues commonly encountered in the base #package's download.file() function and claims to be more efficient

HARUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(HARUrl, dest = "har.zip", mode = "wb")
```
---
---
Read the downloaded files into R and combine the test and training sets.
---
---
```{r}
#Read local files
sub_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

sub_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

#Combine data by add the rows of the training set data to the test set data for #each variable
sub_tot <- rbind(sub_test, sub_train)
x_tot <- rbind(x_test, x_train)
y_tot <- rbind(y_test, y_train)

#Remove files that are no longer needed from the R workspace
rm(sub_test, x_test, y_test, sub_train, x_train, y_train)

#Read files containing information for labeling data
activity_labels <- read.table("activity_labels.txt", stringsAsFactor = FALSE)
features <- read.table("features.txt", stringsAsFactor = FALSE)
```
---
---
Relabel and format variable names and change the activity labels from integers to descriptive names.
---
---
```{r}
library(dplyr)

#Add character labels to the coded activity classes
for(i in 1:length(y_tot$V1)) 
  y_tot[i,2] <- activity_labels[y_tot[i,1], 2]

#Apply feature names to feature values
for(j in 1:length(x_tot))
  {names(x_tot)[j] <- features[j,2]}


#Remove duplicated column names
dup_index <- duplicated(names(x_tot))
x_tot <- x_tot[!dup_index]

#Select only columns containing mean and std of measurements
x_tot <- select(x_tot, contains("mean", ignore.case = TRUE), 
                     contains("std", ignore.case = TRUE))

#Format variable names for measurement variables
for(j in 1:length(x_tot)) {
  names(x_tot)[j] <- gsub("\\()", "", names(x_tot)[j])
  names(x_tot)[j] <- gsub("-", " ", names(x_tot)[j])
}
```
---
---
Combine data from the tables containing information about subject id, activity id and measurements into a single table then complete labeling of variables.
---
---
```{r}
#Combine data
data_tot <- cbind(sub_tot, y_tot$V2, x_tot)

#Rename variables
names(data_tot)[1] <- "Subject"
names(data_tot)[2] <- "Activity"
```
---
---
Reshape data and create output
---
---
```{r}
library(reshape2)

#Produce a long table
melt_data <- melt(data_tot, id.vars = c("Subject", "Activity"))

#Reproduce a wide table and calculate means for each measurement by Subject and Activity
cast_data <- dcast(melt_data, Subject + Activity ~ variable, mean)

#Write tidy dataset to a text file
write.table(cast_data, file = "tidy_har.txt", sep = "|", row.name = FALSE)
```
```