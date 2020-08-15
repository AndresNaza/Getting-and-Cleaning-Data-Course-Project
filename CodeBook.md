This are the main aspects of the data used for this project:

* Source: raw data was obtained from the web (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

* Transformations: 
  * The features file was loaded and a vector was created with the names contained in it
  * A lookup table was loaded with activities codes and names
  * Afterwards, test and train set were loaded, along with the asociated activities and subjects
  * Then, test and train set were merged them into one unique data set, and the variables got labeled appropriately.
  * Later, measurements on the mean and standard deviation for each measurement were extracted, by searching for fields name with "mean" or "std" on them.
  * Finally, a second, independent tidy data set was created with the average of each variable for each activity and each subject. This step is made by grouping the data by the "activity_name" and "subject_code" fields, and calculating the mean of those fields with the word "mean" or "std" on it.

The steps taken can be clearly seen on the script run_analysis.R, saved on this repo.

* Resulting variables:
  * "activity_name": one of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) performed by each person wearing a smartphone (Samsung Galaxy S II) on the waist.
  * "subject_code": one of the 30 volunteers within an age bracket of 19-48 years that carried out the experiment
  * The following variables contain the mean for each activity of each subject of the features measured by the sensors. Additional information can be obtained on the README file located on the UCI HAR Dataset folder.
