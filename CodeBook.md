# Coursera - Getting and Cleaning Data
## Codebook for Course Project

### Operations

To produce the final, tidy dataset the following operations were made
to the raw data; the code in `runAnalysis.R` is extensively documented
and included examples of the data at each transformation step and as
such can be consulted for additional details:

1. All the X and Y data from the train and test datasets was merged
2. Activity labels found in `activity_labels.txt` were used to produce a descriptive name for the activities that replaced the used numeric codes (e.g. "1" > "walking")
3. From this merged dataset were extracted all values dealing with "mean" and "Standard Deviation"; for this it was assumed that all such variables *ended* in `-mean()` or `-std()`.
4. Descriptive variable names were added to this dataset, using the information found in `features.txt`
5. This dataset is saves as `temp_data.csv`: it is a tidy dataset that contains all the mean and SD related values, from both train and test data, with descrptive factor names for the activities and descriptive column names for the variables
6. This dataset is rearranged by melting and casting: first it is melted (from "wide" to "long" format) using subject and activity as identifies, and subsequently recasted into "wide" format but this time all the numeric values are the result of applying `mean()` to all variables according to subject and activity combinations.
7. This separate dataset is saved as `final_data.csv`, a CSV file.


Both files can be read using `read.csv`.  Both files contain tidy datasets (in "wide" format) that adhere to the following rules (cf. 
"Tidy Data", Hadley Wickham, http://vita.had.co.nz/papers/tidy-data.pdf)

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

### Variables

All numeric variables (num) are normalized and bounded within [-1,1].

The features selected for this database come from the accelerometer
and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time
domain signals (prefix 't' to denote time) were captured at a constant
rate of 50 Hz. Then they were filtered using a median filter and a 3rd
order low pass Butterworth filter with a corner frequency of 20 Hz to
remove noise. Similarly, the acceleration signal was then separated
into body and gravity acceleration signals (tBodyAcc-XYZ an d
tGravityAcc-XYZ) using another low pass Butterworth filter with a
corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

To produce this dataset an additional step was taken: the average of
the values for the combination of subject and activity was obtained;
these step is not explicitly mentioned in the descriptions bellow
because it applies to all numeric values.

In short, and while reading the description of each variable, have in mind that:

1. All values are in the dataset are an average for each combination of subject and activity.
2. All numeric variables (num) are normalized and bounded within [-1,1].
3. "Frequency domain" values were obtained by applying FFT to the corresponding "time domain" variable

#### subject (int)
Identifies the subject that performed the activity, within the range 1-30.
#### activity (chr)
A string describing the activity, one of:
```
laying
sitting
standing
walking
walkingdownstairs
walkingupstairs
```
#### tbodyacc-mean-x (num)
Body Acceleration (X axis) mean (time domain).
#### tbodyacc-mean-y (num)
Body Acceleration (Y axis) mean (time domain).
#### tbodyacc-mean-z (num)
Body Acceleration (Z axis) mean (time domain).
#### tbodyacc-std-x (num)
Body Acceleration (X axis) Standard Deviation (time domain).
#### tbodyacc-std-y (num)
Body Acceleration (Y axis) Standard Deviation (time domain).
#### tbodyacc-std-z (num)
Body Acceleration (Z axis) Standard Deviation (time domain).
#### tgravityacc-mean-x (num)
Gravity Acceleration (X axis) mean (time domain).
#### tgravityacc-mean-y (num)
Gravity Acceleration (Y axis) mean (time domain).
#### tgravityacc-mean-z (num)
Gravity Acceleration (Z axis) mean (time domain).
#### tgravityacc-std-x (num)
Gravity Acceleration (X axis) Standard Deviation (time domain).
#### tgravityacc-std-y (num)
Gravity Acceleration (Y axis) Standard Deviation (time domain).
#### tgravityacc-std-z (num)
Gravity Acceleration (Z axis) Standard Deviation (time domain).
#### tbodyaccjerk-mean-x (num)
Body Acceleration Jerk (X axis) mean (time domain).
#### tbodyaccjerk-mean-y (num)
Body Acceleration Jerk (Y axis) mean (time domain).
#### tbodyaccjerk-mean-z (num)
Body Acceleration Jerk (Z axis) mean (time domain).
#### tbodyaccjerk-std-x (num)
Body Acceleration Jerk (X axis) Standard Deviation (time domain).
#### tbodyaccjerk-std-y (num)
Body Acceleration Jerk (X axis) Standard Deviation (time domain).
#### tbodyaccjerk-std-z (num)
Body Acceleration Jerk (X axis) Standard Deviation (time domain).
#### tbodygyro-mean-x (num)
Body Gyroscope (X axis) mean (time domain).
#### tbodygyro-mean-y (num)
Body Gyroscope (Y axis) mean (time domain).
#### tbodygyro-mean-z (num)
Body Gyroscope (Z axis) mean (time domain).
#### tbodygyro-std-x (num)
Body Gyroscope (X axis) Standard Deviation (time domain).
#### tbodygyro-std-y (num)
Body Gyroscope (X axis) Standard Deviation (time domain).
#### tbodygyro-std-z (num)
Body Gyroscope (X axis) Standard Deviation (time domain).
#### tbodygyrojerk-mean-x (num)
Body Gyroscope Jerk (X axis) mean (time domain).
#### tbodygyrojerk-mean-y (num)
Body Gyroscope Jerk (Y axis) mean (time domain).
#### tbodygyrojerk-mean-z (num)
Body Gyroscope Jerk (Z axis) mean (time domain).
#### tbodygyrojerk-std-x (num)
Body Gyroscope Jerk (X axis) Standard Deviation (time domain).
#### tbodygyrojerk-std-y (num)
Body Gyroscope Jerk (Y axis) Standard Deviation (time domain).
#### tbodygyrojerk-std-z (num)
Body Gyroscope Jerk (Z axis) Standard Deviation (time domain).
#### tbodyaccmag-mean (num)
Body Acceleration Magnitude mean (time domain).
#### tbodyaccmag-std (num)
Body Acceleration Magnitude Standard Deviation (time domain).
#### tgravityaccmag-mean (num)
Gravity Acceleration Magnitude mean (time domain).
#### tgravityaccmag-std (num)
Gravity Acceleration Magnitude Standard Deviation (time domain).
#### tbodyaccjerkmag-mean (num)
Body Acceleration Jerk Magnitude mean (time domain).
#### tbodyaccjerkmag-std (num)
Body Acceleration Jerk Magnitude Standard Deviation (time domain).
#### tbodygyromag-mean (num)
Body Gyroscope Magnitude mean (time domain).
#### tbodygyromag-std (num)
Body Gyroscope Magnitude Standard Deviation (time domain).
#### tbodygyrojerkmag-mean (num)
Body Gyroscope Jerk Magnitude mean (time domain).
#### tbodygyrojerkmag-std (num)
Body Gyroscope Jerk Magnitude Standard Deviation (time domain).
#### fbodyacc-mean-x (num)
Body Acceleration (X axis) mean (frequency domain)
#### fbodyacc-mean-y (num)
Body Acceleration (Y axis) mean (frequency domain)
#### fbodyacc-mean-z (num)
Body Acceleration (Z axis) mean (frequency domain)
#### fbodyacc-std-x (num)
Body Acceleration (X axis) Standard Deviation (frequency domain)
#### fbodyacc-std-y (num)
Body Acceleration (Y axis) Standard Deviation (frequency domain)
#### fbodyacc-std-z (num)
Body Acceleration (Z axis) Standard Deviation (frequency domain)
#### fbodyaccjerk-mean-x (num)
Body Acceleration jerk (X axis) mean (frequency domain)
#### fbodyaccjerk-mean-y (num)
Body Acceleration jerk (Y axis) mean (frequency domain)
#### fbodyaccjerk-mean-z (num)
Body Acceleration jerk (Z axis) mean (frequency domain)
#### fbodyaccjerk-std-x (num)
Body Acceleration jerk (X axis) Standard Deviation (frequency domain)
#### fbodyaccjerk-std-y (num)
Body Acceleration jerk (Y axis) Standard Deviation (frequency domain)
#### fbodyaccjerk-std-z (num)
Body Acceleration jerk (Z axis) Standard Deviation (frequency domain)
#### fbodygyro-mean-x (num)
Body Gyroscope (X axis) mean (frequency domain)
#### fbodygyro-mean-y (num)
Body Gyroscope (Y axis) mean (frequency domain)
#### fbodygyro-mean-z (num)
Body Gyroscope (Z axis) mean (frequency domain)
#### fbodygyro-std-x (num)
Body Gyroscope (X axis) Standard Deviation (frequency domain)
#### fbodygyro-std-y (num)
Body Gyroscope (Y axis) Standard Deviation (frequency domain)
#### fbodygyro-std-z (num)
Body Gyroscope (Z axis) Standard Deviation (frequency domain)
#### fbodyaccmag-mean (num)
Body Acceleration Magnitude mean (frequency domain).
#### fbodyaccmag-std (num)
Body Acceleration Magnitude Standard Deviation (frequency domain).
#### fbodybodyaccjerkmag-mean (num)
Body Acceleration Jerk Magnitude mean (frequency domain).
#### fbodybodyaccjerkmag-std (num)
Body Acceleration Jerk Magnitude Standard Deviation (frequency domain).
#### fbodybodygyromag-mean (num)
Body Gyroscope Magnitude mean (frequency domain).
#### fbodybodygyromag-std (num)
Body Gyroscope Magnitude Standard Deviation (frequency domain).
#### fbodybodygyrojerkmag-mean (num)
Body Gyroscope Jerk Magnitude mean (frequency domain).
#### fbodybodygyrojerkmag-std (num)
Body Gyroscope Jerk Magnitude Standard Deviation (frequency domain).