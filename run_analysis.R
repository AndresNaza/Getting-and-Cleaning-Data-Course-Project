### Load libraries


library(tidyverse)


### Check if raw data files exist in the working directory. If not, download them.

if(!file.exists("original_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "original_data.zip")
}


### Check if raw data files are already unzipped in the working directory. If not, unzip them.

if(!file.exists("UCI HAR Dataset")){
  unzip("original_data.zip")
}


### Reading and loading downloaded files

### Load features file, and create a vector with its names
features <- read.table("./UCI HAR Dataset/features.txt",col.names = c("feature_cod","feature_name"),stringsAsFactors = FALSE)
features_names <- features$feature_name

### Load lookup table with activities codes and names
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activity_code","activity_name"),stringsAsFactors = FALSE)


### Load test set, along with the asociated activities (y_test) and subjects (subject_test).
### Merge them into one unique data set (x_test_final), and label the variables appropriately.

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_test_activity_codes <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test_subject_codes <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test_final <- bind_cols(x_test_activity_codes,x_test_subject_codes,x_test)
names(x_test_final) <- c("activity_code","subject_code",features_names)



### Load train set, along with the asociated activities (y_train) and subjects (subject_train).
### Merge them into one unique data set (x_train_final), and label the variables appropriately.

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_train_activity_codes <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train_subject_codes <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train_final <- bind_cols(x_train_activity_codes,x_train_subject_codes,x_train)
names(x_train_final) <- c("activity_code","subject_code",features_names)



### Merge both datasets (test and train), and afterwards include the activity names.

merged_dataset <- bind_rows(x_test_final,x_train_final)
merged_dataset_with_activity <- inner_join(activity_names,merged_dataset, by=c("activity_code"="activity_code"))


### Extract measurements on the mean and standard deviation for each measurement, by searching for fields name
### with "mean" or "std" on them. Save them into a new dataset called "selected_measurements"

selected_measurements <- select(merged_dataset_with_activity,activity_name,subject_code,contains(c("mean()","std()")))



### Finally, create a second, independent tidy data set with the average of each variable for each activity and each subject.
### This step is made by grouping the data by the "activity_name" and "subject_code" fields, and calculating the mean of those
### fields with the word "mean" or "std" on it.

average_by_activity_and_subject <- selected_measurements %>% group_by(activity_name,subject_code) %>% summarise(across(contains(c("mean()","std()")),mean))


### Write this last table on a .txt file.

write.table(average_by_activity_and_subject,"average_by_activity_and_subject.txt",row.names = FALSE)
