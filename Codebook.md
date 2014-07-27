The **run_analysis** function has the following syntax

```sh
run_analysis(datafilename="merged.csv", summaryfilename="summary.csv")
```

It performs the steps discussed in the project description for generating two clean data sets as specified by the two input parameters. The clean data file (specified by *datafilename*) contains the data merged from training and testing subsets for mean and standard deviation features, and the summary file (specified by *summaryfilename*) extracts only the mean statistics of each feature across each activity and subject. 

To extract the columns from the raw data set corresponding to the mean and standard deviations, a grep function is used to select feature names containing patterns '-mean()' and '-std()'. The mean frequency columns are ignored by excluding the pattern '-meanFreq()' from the subset selected for the mean features. Consequently, the processed data file has **68** columns, including a subset of **66** features extracted from the total number of 561 features in the raw data, plus **2** labels indicating the subject and activity of each record (i.e. row). 

The selected features include the mean and standard deviation of the following attributes

* *tBodyAcc-XYZ, tBodyAccMag*: 4 features
* *tGravityAcc-XYZ, tGravityAccMag*: 4 features
* *tBodyAccJerk-XYZ, tBodyAccJerkMag*: 4 features
* *tBodyGyro-XYZ, tBodyGyroMag*: 4 features
* *tBodyGyroJerk-XYZ, tBodyGyroJerkMag*: 4 features
* *fBodyAcc-XYZ, fBodyAccMag*: 4 features
* *fBodyAccJerk-XYZ, fBodyAccJerkMag*: 4 features
* *fBodyGyro-XYZ, fBodyGyroMag*: 4 features
* *fBodyGyroJerkMag*: 1 feature

This gives rise to a total of (4\*8+1)\*2=66 features at output. Each feature has been 
already scaled to the range [-1,1] in the raw data, so there is no need for feature normalisation. Features are all *numerical* values, whereas the subject and activity labels are *integers* and *factors*.

The summary file further merges rows of the processed data that belong to the same subject and activity by taking their mean values. This leads to 180 records for different combinations of 30 subjects and 6 activities. 
