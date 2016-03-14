## CODEBOOK FOR DE GETTING AND CLEANING DATA - COURSE PROJECT
The objective of this codebook is to explain the work done to acomplish the task required to pass the Getting and Cleaning Data course

This Code Book is arreged in three chapters
1. Origin of the data
2. Accion steps took getting from the data suministrated in point one, to the tidy data set presented required to pass this course ("run_analysis.R" file)
3. Variables Book

#1. ORIGIN OF THE DATA
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at 
the site where the data was obtained: [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

An abstract of what you can find there is exposed next:
- Human Activity Recognition Using Smartphones Dataset, Version 1.0)
- Authors: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.,Smartlab - Non Linear Complex Systems Laboratory,DITEN - Università degli Studi di Genova.,Via Opera Pia 11A, I-16145, Genoa, Italy.,activityrecognition@smartlab.ws,www.smartlab.ws
- Sample and observations: the experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the
data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the
test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec
and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass 
filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
	- For each record it is provided: 
						- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
						- Triaxial Angular velocity from the gyroscope. 
						- A 561-feature vector with time and frequency domain variables. 
						- Its activity label. 
						- An identifier of the subject who carried out the experiment.
	- The dataset includes the following files:
						- 'README.txt'
						- 'features_info.txt': Shows information about the variables used on the feature vector.
						- 'features.txt': List of all features.
						- 'activity_labels.txt': Links the class labels with their activity name.
						- 'train/X_train.txt': Training set.
						- 'train/y_train.txt': Training labels.
						- 'test/X_test.txt': Test set.
						- 'test/y_test.txt': Test labels.
	- The following files are available for the train and test data. Their descriptions are equivalent. 
						- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
						- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
						- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
						- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

	-  Feature Selection: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These
                              time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter 
                              and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was 
                              then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter
                              with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk
			      signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the
			      Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was
                              applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, 
                              fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature
                              vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

#2. STEPS FOR GETTING FROM THE ORIGIN DATA TO THE TIDY.TXT FILE ("run_analysis.R" file)
TASK: 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Obtain the data from the url mentioned. First check if the data exist, if not, it download it and unzip it.
2. Import the features from the "features.txt" file. This file, contains the columns name that discribes wich measurement is it. Because the project requires only 
to work with the measurement of means and standar deviation, the steps followed where: first import the entire file to have all the column names, then obtain the index
only of the columns with mean() or std() in the name to apply to the Y_xxxx.txt file that have the variables data, and third make the column names more readably.
3. (Applies to Train and Test txt) Import the subject_xxxx.txt file that has the information of the volunteer that gave the measurement, second import the data per se
only of the variables that are defined in the project task using the info obtain in item 2, third, import the data that tell wich activity was the volunteer performing,
and finally put all together.  (for more clarity the column names are added from the beging)
4. Merge the data set of train and test having the column sample to identify the two groups. And make the subject a factor.
5. Import the activity_labels.txt file to add the activity descripcion to the full data set that until now it has the code but not the description. For that it is required
the plyr package, to use de join function. Some rearrange is done also.
6. Melt the full data set by subject and activity and calculate the mean of every variable. The reshape2 package is required
7. Export the tidy data set created to a txt.

#3. VARIABLES BOOK
 [1] "subject"                   "activity_description"      "tBodyAcc_meanX"            "tBodyAcc_meanY"            "tBodyAcc_meanZ"           
 [6] "tBodyAcc_stdX"             "tBodyAcc_stdY"             "tBodyAcc_stdZ"             "tGravityAcc_meanX"         "tGravityAcc_meanY"        
[11] "tGravityAcc_meanZ"         "tGravityAcc_stdX"          "tGravityAcc_stdY"          "tGravityAcc_stdZ"          "tBodyAccJerk_meanX"       
[16] "tBodyAccJerk_meanY"        "tBodyAccJerk_meanZ"        "tBodyAccJerk_stdX"         "tBodyAccJerk_stdY"         "tBodyAccJerk_stdZ"        
[21] "tBodyGyro_meanX"           "tBodyGyro_meanY"           "tBodyGyro_meanZ"           "tBodyGyro_stdX"            "tBodyGyro_stdY"           
[26] "tBodyGyro_stdZ"            "tBodyGyroJerk_meanX"       "tBodyGyroJerk_meanY"       "tBodyGyroJerk_meanZ"       "tBodyGyroJerk_stdX"       
[31] "tBodyGyroJerk_stdY"        "tBodyGyroJerk_stdZ"        "tBodyAccMag_mean"          "tBodyAccMag_std"           "tGravityAccMag_mean"      
[36] "tGravityAccMag_std"        "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"       "tBodyGyroMag_mean"         "tBodyGyroMag_std"         
[41] "tBodyGyroJerkMag_mean"     "tBodyGyroJerkMag_std"      "fBodyAcc_meanX"            "fBodyAcc_meanY"            "fBodyAcc_meanZ"           
[46] "fBodyAcc_stdX"             "fBodyAcc_stdY"             "fBodyAcc_stdZ"             "fBodyAccJerk_meanX"        "fBodyAccJerk_meanY"       
[51] "fBodyAccJerk_meanZ"        "fBodyAccJerk_stdX"         "fBodyAccJerk_stdY"         "fBodyAccJerk_stdZ"         "fBodyGyro_meanX"          
[56] "fBodyGyro_meanY"           "fBodyGyro_meanZ"           "fBodyGyro_stdX"            "fBodyGyro_stdY"            "fBodyGyro_stdZ"           
[61] "fBodyAccMag_mean"          "fBodyAccMag_std"           "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"   "fBodyBodyGyroMag_mean"    
[66] "fBodyBodyGyroMag_std"      "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 

- subject are the volunteers that took the experiment
- activity_description is the activity that was been done while the measeament was took
- the rest of the variables are the mean of the variables explained in the first section
