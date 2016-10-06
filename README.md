## Tidy Data of Human Activity Recognition  ##
- Source of Raw data: *Human Activity Recognition Using Smartphones Dataset* - Version 1.0
- Download path: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
### Raw Data From Experiment ###
The experiment chose 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, we can capture 3-axial linear acceleration and 3-axial angular velocity. All the obtained dataset was randomly partitioned into two groups, where 70% of the volunteers was selected as the training data and 30% the test data. 

In the begining of tidying data, we shoud ask a question: what data are we need? So we use `read.table("UCI HAR Dataset/features.txt",header=F)` to check the whole features.
Based on the 'features_info.txt', we can know how the features were obtained: 


1. The 561 features are firstly selected from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered with a corner frequency of 20 Hz to remove noise. (like tBodyAcc-XYZ and tGravityAcc-XYZ) 



2. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these 3-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 



3. Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

### Observations and variables of Tidy Data ###
**Variables**:Base on the review of raw data, we can image that the tidy data should include subjects, activities, features. In other words, each row indicates that who performed which activity and the  561 features obtained by the activity of that person. So the data we need in each row are:

- An identifier of the subject who carried out the experiment. (ID of training group is from `"UCI HAR Dataset/train/subject_train.txt"`; ID of test group are from `"UCI HAR Dataset/train/subject_test.txt"`)
- Its activity label. (Training labels from '`train/y_train.txt`'; test labels from '`test/y_test.txt`'; ) 
- A 561-feature vector.(Features of trainging group from '`train/X_train.txt`';  features of test group from '`test/X_test.txt`')
 

**Observations**: 10297, 2946 comes from test group and 7351 from train group.

The number of row of file `y_test.txt`, `X_test.txt` and `subject_test.txt` are all 2946;
The number of row of file `y_train.txt`, `X_train.txt` and `subject_train.txt` are all 7351.


----------
### Description of how the script works ###
**Merge** the test group data and train group data into one data set by using `rbind()` function.(dim: 10297*563)

**Subset** the portion only with the mean and standard deviation by using `grepl()` function to generate a logic index vector.(dim:10297*68)

**Use** the descriptive activity name to replace the activity number by write a for-loop.

**Substitute** the feature symbols with the descriptive feature names by using `sub()` function.

----------
### creates an independent tidy data set ###
with the average of each variable for each activity and each subject, for example, if we want to know the average values of features of the first person's walking activity, we should get a subset data only when the activity column is "WALKING". And actually we can use the `tapply()` function to get the mean for each person.

Firstly, create a matrix of dimension 180 * 68. (30 persons and 6 activities of each person, so the new data set should have 180 rows) 

Then, write a for-loop to subset data for each activity, and write another for-loop in the first loop to calculate mean by group of subject(person) for the activity.  

Finally, assign column names and row names to the new data set.
