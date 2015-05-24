library(downloader)

#HARUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download(HARUrl, dest = "har.zip", mode = "wb")

##Read local files
sub_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

sub_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

##Combine data
sub_tot <- rbind(sub_test, sub_train)
x_tot <- rbind(x_test, x_train)
y_tot <- rbind(y_test, y_train)

rm(sub_test, x_test, y_test, sub_train, x_train, y_train)

activity_labels <- read.table("activity_labels.txt", stringsAsFactor = FALSE)
features <- read.table("features.txt", stringsAsFactor = FALSE)

#char_feat <- as.character(features)
#data_names <- c("Subject", "Activity", char_feat)

#Add character labels to the coded activity classes
for(i in 1:length(y_tot$V1)) 
  y_tot[i,2] <- activity_labels[y_tot[i,1], 2]

#Apply feature names to feature values
for(j in 1:length(x_tot))
  {names(x_tot)[j] <- features[j,2]}

data_total <- cbind(sub_tot, y_tot$V2, x_tot)

#Remove duplicated column names
dup_index <- duplicated(names(x_tot))
x_tot <- x_tot[!dup_index]

#Select only columns containing mean and std 
x_tot <- select(x_tot, contains("mean", ignore.case = TRUE), 
                     contains("std", ignore.case = TRUE))

#Format variable names
for(j in 1:length(x_tot)) {
  names(x_tot)[j] <- gsub("\\()", "", names(x_tot)[j])
  names(x_tot)[j] <- gsub("-", " ", names(x_tot)[j])
}
#Combine data
data_tot <- cbind(sub_tot, y_tot$V2, x_tot)

#Rename variables
names(data_tot)[1] <- "Subject"
names(data_tot)[2] <- "Activity"

library(dplyr)
library(tidyr)

melt_data <- melt(data_tot, id.vars = c("Subject", "Activity"))
cast_data <- dcast(melt_data, Subject + Activity ~ variable, mean)

write.table(cast_data, file = "har.txt", sep = "|", row.name = FALSE)

